defmodule Auth.Repo.Migrations.Confirm do
  use Ecto.Migration

  def change do
    create table(:confirm, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:user_id, references(:user, type: :uuid, on_delete: :delete_all, ))
      add(:number, :string)
      add(:confirmed, :boolean)
      timestamps()
    end


  end
end
