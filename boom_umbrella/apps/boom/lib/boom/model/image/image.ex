defmodule Boom.Model.Image do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "image" do
    field(:image_url, :string)
    field(:content_type, :string)
    field(:user_id, :binary_id)
    field(:path, :string)
    field(:name, :string)
    field(:table_type, TableType, default: "global")
    field(:type_img, ImageType, default: "global")
    field(:parent_id, :binary_id)

    timestamps()
  end

  @required_fields ~w(image_url path content_type)a
  @optional_fields ~w(path name parent_id user_id table_type)a
  use Boom.Use.RepoBase, repo: Boom.Repo
  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
