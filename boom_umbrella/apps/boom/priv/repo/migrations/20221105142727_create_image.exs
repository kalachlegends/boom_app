defmodule Boom.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:image, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:image_url, :string)
      add(:user_id, references(:user, type: :uuid, on_delete: :nothing))
      add(:content_type, :string)
      add(:path, :string)
      add(:name, :string)
      add(:table_type, :string)
      add(:parent_id, :binary_id)
      add(:type_img, :string)
      timestamps()
    end

    create(index(:image, [:user_id]))
  end
end
