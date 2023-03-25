defmodule Boom.Model.Incident do
  use Ecto.Schema
  import Ecto.Changeset

  schema "incident" do
    field :close_dateq, :utc_datetime
    field :description, :string
    field :location_address, :string
    field :location_id, :integer
    field :priority, :string
    field :status, :string
    field :title, :string
    field :user_id, :binary_id
    field :org_id, :id

    timestamps()
  end

  @doc false
  def changeset(incident, attrs) do
    incident
    |> cast(attrs, [:title, :description, :status, :priority, :close_dateq, :location_id, :location_address])
    |> validate_required([:title, :description, :status, :priority, :close_dateq, :location_id, :location_address])
  end
end
