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
  @required_fields ~w(full_name name parent_id type)a
   @optional_fields ~w()a
   def changeset(model, attrs) do
     model
     |> cast(attrs, @required_fields ++ @optional_fields)
     |> validate_required(@optional_fields)
   end
end
