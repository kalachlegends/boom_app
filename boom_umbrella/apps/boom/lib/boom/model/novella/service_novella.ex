defmodule Boom.Service.Novella do
  alias Boom.Model.Novella

  alias Boom.Model.Tree
  alias Boom.Model.Like
  alias Boom.Model.Views
  alias Boom.Service.Tree, as: TreeService
  alias Boom.Repo
  import Ecto.Query

  def create(map) do
    with {:ok, novella} <- Novella.add(map),
         {:ok, _view} <-
           Views.create(%{
             parent_id: novella.id,
             table_type: :novella
           }),
         {:ok, tree} <- TreeService.create(novella.id, :not_delete, %{user_id: map["user_id"]}),
         {:ok, novella} <- Novella.update(novella, %{tree_id: tree.id}),
         {:ok, _like} <-
           Like.create(%{
             parent_id: novella.id,
             type_parent: :novella
           }) do
      {:ok, novella, tree}
    end
  end

  def get_public_new_novells() do
    items =
      from(novela in Novella,
        where: novela.type_status == "public",
        order_by: novela.inserted_at,
        join: like in Like,
        on: like.parent_id == novela.id and like.type_parent == :novella,
        select: %{
          novella: novela,
          like: like
        }
      )
      |> Repo.all()

    {:ok, items}
  end

  def get_public_new_novells() do
    items =
      from(novela in Novella,
        where: novela.type_status == "public",
        order_by: novela.inserted_at,
        join: like in Like,
        on: like.parent_id == novela.id and like.type_parent == :novella,
        select: %{
          novella: novela,
          like: like
        }
      )
      |> Repo.all()

    {:ok, items}
  end

  def get_public_novells(search, page, type_status \\ :public, limit \\ 10) do
    search = "%#{search}%"

    {query_pagination, count} =
      from(
        novella in Novella,
        where: ilike(novella.name, ^search) and ^type_status == novella.type_status,
        order_by: novella.updated_at,
        join: like in Like,
        on: like.parent_id == novella.id and like.type_parent == :novella,
        order_by: like.counts_like,
        select: %{
          novella: novella,
          like: like
        }
      )
      |> Repo.pagination(page, limit)

    {query_pagination |> Repo.all([]), count}
  end

  def delete_novella(novella_id) do
    with {:ok, novella} <-
           Novella.update_by_id(novella_id, %{
             tree_id: nil
           }) do
      Repo.delete(novella_id)

      from(
        tree in Tree,
        where: tree.novella_id == ^novella.id
      )
      |> Repo.delete_all()
    end
  end
end
