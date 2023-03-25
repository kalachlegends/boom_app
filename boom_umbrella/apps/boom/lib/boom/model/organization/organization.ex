defmodule Boom.Model.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization" do
    field(:locations_list, {:array, :integer})
    field(:title, :string)
    field(:user_id, :binary_id)

    timestamps()
  end

  use(Boom.Use.RepoBase, repo: Boom.Repo)

  @doc false
  @required_fields ~w(locations_list title user_id)a
  @optional_fields ~w()a
  def changeset(model, attrs) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@optional_fields)
  end
end
