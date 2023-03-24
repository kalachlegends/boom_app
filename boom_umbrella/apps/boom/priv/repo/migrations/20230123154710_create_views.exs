defmodule Boom.Repo.Migrations.CreatePublic do
  use Ecto.Migration

  def change do
    create table(:views, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:parent_id, :binary_id)
      add(:counts_viewed_uniq, :integer)
      add(:counts_viewed_unkown, :integer)
      add(:table_type, :string)
      timestamps()
    end

    create index(:views, [:parent_id])
  end
end
