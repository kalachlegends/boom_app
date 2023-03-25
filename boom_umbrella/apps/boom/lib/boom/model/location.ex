defmodule Boom.Model.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "location" do
    field :full_name, :string
    field :name, :string
    field :parent_id, :integer
    field :type, :string

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:id, :parent_id, :type, :name, :full_name])
    |> validate_required([:id, :parent_id, :type, :name, :full_name])
  end
end
