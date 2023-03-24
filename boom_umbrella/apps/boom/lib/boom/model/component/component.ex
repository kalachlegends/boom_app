defmodule Boom.Model.Component do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "component" do
    field(:component_map, :map)
    field(:name, :string)
    field(:type, :string)
    field(:novella_id, :binary_id)
    field(:user_id, :binary_id)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(name type novella_id user_id)a
  @optional_fields ~w(component_map)a
  @doc false
  def changeset(component, attrs) do
    component
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@optional_fields)
  end
end
