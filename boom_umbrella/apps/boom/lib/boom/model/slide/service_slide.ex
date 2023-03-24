defmodule Boom.Service.Slide do
  alias Boom.Model.Slide
  alias Boom.Repo

  import Ecto.Query

  def create(map) do
    count = get_by_count_by_tree_id(map["tree_id"])
    count_string = count |> Integer.to_string()
    name = "Slide " <> count_string

    map = map |> Map.merge(%{"sort_number" => count, "name" => name})

    with {:ok, slide} <- Slide.add(map) do
      {:ok, slide}
    end
  end

  def get_by_count_by_tree_id(tree_id) do
    query =
      from(
        slide in Slide,
        where: slide.tree_id == ^tree_id
      )

    count = Repo.aggregate(query, :count, :id)
    if is_nil(count), do: 0, else: count
  end

  def get_current_next_slide(slide_id, tree_id) do
    if is_nil(tree_id), do: throw({:error, "tree_id_is_nil"})

    slide =
      from(
        slide in Slide,
        where: slide.id == ^slide_id and slide.tree_id == ^tree_id
      )
      |> Repo.one()

    if is_nil(slide), do: throw({:error, :not_found})

    slide_prev =
      from(
        slide in Slide,
        where: slide.sort_number == ^slide.sort_number - 1 and slide.tree_id == ^tree_id
      )
      |> Repo.one()

    slide_next =
      from(
        slide in Slide,
        where: slide.sort_number == ^slide.sort_number + 1 and slide.tree_id == ^tree_id
      )
      |> Repo.one()

    {:ok,
     %{
       slide_prev: slide_prev,
       slide_current: slide,
       slide_next: slide_next
     }}
  end
end
