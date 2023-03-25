defmodule Boom.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:location) do
      add :parent_id, :integer
      add :type, :string
      add :name, :string
      add :full_name, :string

      timestamps()
    end
  end
end
