defmodule Boom.Repo.Migrations.AlterMoneyMovement do
  use Ecto.Migration

  def change do
    alter table :money_movement do
      add :incident_id, references(:incident, type: :uuid, on_delete: :nothing)
    end
  end
end
