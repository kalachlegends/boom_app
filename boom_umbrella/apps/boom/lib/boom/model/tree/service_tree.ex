defmodule Boom.Service.Tree do
  alias Boom.Model.Tree
  alias Boom.Model.Slide
  alias Boom.Model.Novella
  alias Boom.Model.Event
  alias Boom.Repo

  import Ecto.Query

  def create(novella_id, type \\ :not_delete, map \\ %{}) do
    count = count_tree_by_novella_id(novella_id) |> Integer.to_string()
    name = "Tree " <> count

    with {:ok, tree} <-
           Tree.add(
             %{"novella_id" => novella_id, "type_delete" => type, "name" => name}
             |> Map.merge(map)
           ),
         {:ok, slide} <-
           Slide.add(%{
             tree_id: tree.id
           }),
         {:ok, tree} <-
           Tree.update(tree, %{slide_id: slide.id}) do
      async_update_novella_tree_count(novella_id)
      {:ok, tree}
    end
  end

  defp async_update_novella_tree_count(novella_id) do
    Task.async(fn ->
      Novella.update_by_id(novella_id, %{
        tree_count: count_tree_by_novella_id(novella_id)
      })
    end)
  end

  def count_tree_by_novella_id(novella_id) do
    query =
      from(
        tree in Tree,
        where: tree.novella_id == ^novella_id
      )

    count = Repo.aggregate(query, :count, :id)
    if is_nil(count), do: 0, else: count
  end

  def get_slide_by_tree_id(tree_id) do
    slides =
      from(
        slide in Slide,
        where: slide.tree_id == ^tree_id,
        left_join: event in Event,
        on: event.slide_id == slide.id,
        order_by: slide.sort_number,
        select: %{
          slide: slide,
          event: event
        }
      )
      |> Repo.all([])

    if slides == [], do: {:error, :not_found}, else: {:ok, slides}
  end
end
