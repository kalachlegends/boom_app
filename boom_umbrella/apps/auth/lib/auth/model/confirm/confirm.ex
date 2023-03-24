defmodule Auth.Model.Confirm do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "confirm" do
    field(:user_id, :binary_id)
    field(:number, :string, default: "")
    field(:confirmed, :boolean, default: false)
    timestamps()
  end

  use Auth.RepoBase, repo: Auth.Repo
  @required_fields ~w(user_id confirmed)a
  @optional_fields ~w(number)a

  def changeset(public, attrs) do
    public
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> change(%{number: Ecto.UUID.generate()})
    |> unique_constraint(:user_id,
      name: :confirm_user_id_index,
      message: "Please check your email"
    )
  end
end
