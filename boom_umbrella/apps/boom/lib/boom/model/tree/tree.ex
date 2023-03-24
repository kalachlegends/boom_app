defmodule Boom.Model.Tree do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tree" do
    field(:name, :string, default: "Unitled")
    field(:type_delete, TreeTypeDelete, default: "delete")
    field(:type, TreeType, default: "tree")
    field(:max_point, :integer, default: 100)
    field(:novella_id, :binary_id)
    field(:slide_id, :binary_id)
    field(:tree_id, :binary_id)
    field(:user_id, :binary_id)

    has_one(:novella, Boom.Model.Novella)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(name novella_id)a
  @optional_fields ~w(type_delete max_point user_id slide_id type tree_id)a
  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
