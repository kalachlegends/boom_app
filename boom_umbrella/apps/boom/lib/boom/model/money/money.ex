defmodule Boom.Model.Money do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "money" do
    field(:org_id, :binary_id)
    field(:cash, :map)
    has_one(:organization, Boom.Model.Organization)
    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo

  @doc false
  @required_fields ~w(org_id cash)a
  @optional_fields ~w()a
  def changeset(model, attrs) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@optional_fields)
  end
end
