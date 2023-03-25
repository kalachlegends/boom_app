defmodule Boom.Repo.Migrations.CreateIncident do
  use Ecto.Migration

  def change do
    create table(:incident, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :status, :string
      add :priority, :string
      add :close_dateq, :utc_datetime
      add :location_id, references(:location, on_delete: :nothing)
      add :location_address, :string
      add :user_id, references(:user, type: :uuid, on_delete: :nothing)
      add :org_id, references(:organization, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:incident, [:user_id])
    create index(:incident, [:org_id])
  end
end
