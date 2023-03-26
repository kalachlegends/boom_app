defmodule Boom.Model.MoneyMovement do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "money_movement" do
    field(:org_id, :binary_id)
    field(:cash, :map)
    field(:type, :string)
    field(:movement, :integer)
    field(:attrs, :map)
    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo

  @doc false
  @required_fields ~w(org_id cash type movement attrs)a
  @optional_fields ~w()a
  def changeset(model, attrs) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@optional_fields)
  end
end
