defmodule Boom.Repo.Migrations.AlterUser do
  use Ecto.Migration

  def change do
    alter table("user") do
      add(:location_id, references(:location), null: true)
      add(:location_address, :string)
    end
  end
end
