defmodule Boom.Model.Novella do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "novella" do
    field(:description, :string)
    field(:img_url, :string)
    field(:tree_count, :integer)
    field(:name, :string, default: "Unitled")
    belongs_to(:tree, Boom.Model.Tree)
    field(:type_novella, NovellaType)
    field(:type_status, NovellaTypeStatus, default: "private")
    belongs_to(:user, Auth.Model.User)

    has_one(:views, Boom.Model.Views, foreign_key: :parent_id)
    has_one(:like, Boom.Model.Like, foreign_key: :parent_id)
    field(:arr_img_url, {:array, :string}, default: [])

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(type_novella user_id)a
  @optional_fields ~w(description img_url name arr_img_url tree_id type_status tree_count)a
  @doc false
  def changeset(novella, attrs) do
    novella
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
