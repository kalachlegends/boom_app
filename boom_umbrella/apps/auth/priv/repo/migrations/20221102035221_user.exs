defmodule Auth.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:user,  primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:login, :string)
      add(:email, :string)
      add(:password, :string)
      add(:data, :map)
      add(:is_registred, :boolean)
      add(:roles, {:array, :string})

      timestamps()
    end

    create(unique_index(:user, [:email]))
    create(unique_index(:user, [:login]))
  end
end
