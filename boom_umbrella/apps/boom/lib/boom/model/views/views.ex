defmodule Boom.Model.Views do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "views" do
    field(:parent_id, :binary_id)
    field(:counts_viewed_uniq, :integer, default: 0)
    field(:counts_viewed_unkown, :integer, default: 0)
    field(:table_type, TableType)
    # belongs_to(:novella, Boom.Model.Novella,)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(parent_id counts_viewed_uniq counts_viewed_unkown table_type)a
  @optional_fields ~w()a

  def changeset(public, attrs) do
    public
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
