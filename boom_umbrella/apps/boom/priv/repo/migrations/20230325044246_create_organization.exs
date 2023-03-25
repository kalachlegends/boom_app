defmodule Boom.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organization, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :locations_list, {:array, :integer}
      add :user_id, references(:user, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:organization, [:user_id])
  end
end
