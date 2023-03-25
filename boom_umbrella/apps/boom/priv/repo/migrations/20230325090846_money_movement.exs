defmodule Boom.Repo.Migrations.MoneyMovement do
  use Ecto.Migration

  def change do
    create table(:money_movement, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:org_id, references(:organization, type: :uuid, on_delete: :nothing))
      add(:cash, :map)
      add(:type, :text)
      add(:movement, :integer)
      add(:attrs, :map)

      timestamps()
    end

    create(index(:money_movement, [:org_id]))
  end
end
