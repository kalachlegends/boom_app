defmodule Auth.Model.User do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "user" do
    field(:data, :map)
    field(:email, :string)
    field(:password, :string)
    field(:login, :string)
    field(:repassword, :string, virtual: true)
    field(:is_registred, :boolean, default: false)
    field(:roles, {:array, :string}, default: ["tenant"])
    timestamps()
  end

  use Auth.RepoBase, repo: Auth.Repo
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :data, :login, :repassword, :is_registred, :roles])
    |> validate_required([:email, :password, :data, :login, :roles])
    |> validate_format(:email, ~r/@/, message: "isn't valid email")
    |> validate_length(:password,
      min: 3,
      max: 32
      # message: "Пароль не может быть меньше 4 и не больше 32"
    )
    |> validate_length(:login,
      min: 3,
      max: 32
      # message: "Логин не может быть меньше 4 и не больше 32"
    )
    |> unique_constraint(:login, name: :user_login_index, message: "Has already been taken login")
    |> unique_constraint(:email, name: :user_email_index, message: "Has already been taken email")
    |> PwHelper.Changeset.password_check(:password, :repassword)
    |> PwHelper.Changeset.map_validate_check(:data, ["img", "name"])
    |> change(password: PwHelper.Hash.hash(attrs[:password] || attrs["password"]))
    |> update_change(:login, fn x ->
      handler_normalize_string(x)
    end)
    |> update_change(:email, fn x ->
      handler_normalize_string(x)
    end)
  end

  defp handler_normalize_string(x) do
    String.downcase(x)
  end

  def changeset_profile(struct, params \\ %{}) do
    struct
    |> cast(params, [:data])
    |> PwHelper.Changeset.map_validate_check(:data, ["img", "name"])
  end

  def changeset_update_is_registred(struct, params \\ %{}) do
    struct
    |> cast(params, [:is_registred])
    |> Auth.Repo.update()
  end

  def update_profile(item, opts) do
    item
    |> changeset_profile(opts_to_map(opts))
    |> Auth.Repo.update()
  end

  def restore_password(item, attrs) do
    item
    |> cast(attrs, [:password])
    |> change(password: PwHelper.Hash.hash(attrs[:password]))
    |> Auth.Repo.update()
  end
end
