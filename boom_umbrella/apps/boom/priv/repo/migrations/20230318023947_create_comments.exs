defmodule Boom.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add :parent_id, :uuid
      add :body, :text
      add :table_type, :string
      add(:user_id, references(:user, type: :uuid, on_delete: :nothing))
      timestamps()
    end

    alter table(:comments) do
      add(:comments_id, references(:comments, type: :uuid, on_delete: :nothing))
    end

    create(index(:comments, [:parent_id, :user_id]))
  end
end
