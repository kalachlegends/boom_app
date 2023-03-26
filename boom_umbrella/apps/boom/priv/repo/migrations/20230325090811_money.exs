defmodule Boom.Repo.Migrations.Money do
  use Ecto.Migration

  def change do
    create table(:money, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:org_id, references(:organization, type: :uuid, on_delete: :nothing))
      add(:cash, :map)

      timestamps()
    end

    create(index(:money, [:org_id]))
  end
end
