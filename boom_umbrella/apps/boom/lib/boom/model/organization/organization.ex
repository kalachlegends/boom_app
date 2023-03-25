defmodule Boom.Model.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organization" do
    field :locations_list, {:array, :integer}
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:title, :locations_list])
    |> validate_required([:title, :locations_list])
  end
end
