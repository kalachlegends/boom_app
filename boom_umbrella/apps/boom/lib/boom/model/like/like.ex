defmodule Boom.Model.Like do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "like" do
    field(:counts_like, :integer, default: 0)
    field(:counts_dis_like, :integer, default: 0)
    field(:parent_id, :binary_id)
    field(:type_parent, TableType)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(type_parent parent_id)a
  @optional_fields ~w(counts_like counts_dis_like)a
  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
