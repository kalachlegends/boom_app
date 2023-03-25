defmodule Boom.Model.Incident do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "incident" do
    field(:close_dateq, :utc_datetime)
    field(:description, :string)
    field(:location_address, :string)
    field(:location_id, :integer)
    field(:priority, IncidentPriority, default: "low")
    field(:status, IncidentStatus, default: "backlog")
    field(:title, :string)
    field(:user_id, :binary_id)
    field(:org_id, :binary_id)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo

  @doc false
  @required_fields ~w(description location_address location_id title user_id org_id)a
  @optional_fields ~w(status priority close_dateq)a
  def changeset(model, attrs) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
