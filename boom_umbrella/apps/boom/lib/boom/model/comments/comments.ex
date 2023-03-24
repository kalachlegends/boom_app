defmodule Boom.Model.Comments do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field(:body, :string)
    field(:comment_id, Ecto.UUID)
    field(:parent_id, Ecto.UUID)
    field(:table_type, :string)
    field(:user_id, Ecto.UUID)

    timestamps()
  end

  use(Boom.Use.RepoBase, repo: Boom.Repo)
  @required_fields ~w(user_id table_type body comment_id parent_id )a
  @optional_fields ~w()a
  def changeset(comments, attrs) do
    comments
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@optional_fields)
  end
end
