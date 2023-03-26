defmodule Boom.Model.UserLikes do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "user_likes" do
    field(:parent_id, :binary_id)
    field(:user_id, :binary_id)
    field(:type_like, LikeType)
    field(:type_parent, TableType)
    has_one(:views, NvDesign.Model.Views, foreign_key: :parent_id)
    has_one(:like, NvDesign.Model.Like, foreign_key: :parent_id)
    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(parent_id user_id type_parent)a
  @optional_fields ~w(type_like)a
  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
