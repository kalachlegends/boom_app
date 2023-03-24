defmodule Boom.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:title, :string)
      add(:description, :text)
      add(:body, :text)
      add(:tags, {:array, :string})
      add(:type, :string)

      add(:user_id, references(:user, type: :uuid, on_delete: :nothing))

      timestamps()
    end

    create(index(:post, [:user_id]))
  end
end
