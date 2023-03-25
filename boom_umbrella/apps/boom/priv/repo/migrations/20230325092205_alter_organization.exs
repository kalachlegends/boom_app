defmodule Boom.Repo.Migrations.AlterOrganization do
  use Ecto.Migration

  def change do
    alter table(:organization) do
      add(:money_id, references(:money, type: :uuid, on_delete: :nothing))
    end
  end
end
