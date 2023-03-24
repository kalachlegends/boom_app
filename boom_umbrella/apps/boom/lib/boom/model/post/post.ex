defmodule Boom.Model.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "post" do
    field(:description, :string)
    field(:tags, {:array, :string})
    field(:title, :string)
    field(:body, :string)
    field(:user_id, :id)
    field(:type, :string)

    timestamps()
  end

  use Boom.Use.RepoBase, repo: Boom.Repo
  @required_fields ~w(user_id tags title type)a
  @optional_fields ~w(description body)a

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
