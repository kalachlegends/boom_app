defmodule Boom.Repo.Migrations.CreateUserLikes do
  use Ecto.Migration

  def change do
    LikeType.create_type()

    create table(:user_likes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :parent_id, :binary_id
      add :user_id, references(:user, type: :uuid, on_delete: :nothing)
      add :type_like, :like_type
      add :type_parent, :string

      timestamps()
    end

    create index(:user_likes, [:user_id, :parent_id])
  end
end
