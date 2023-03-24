defmodule Boom.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:like, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:parent_id, :binary_id)
      add(:counts_like, :integer)
      add(:counts_dis_like, :integer)
      add(:type_parent, :string)

      timestamps()
    end

    create index(:like, [:parent_id])
  end
end
