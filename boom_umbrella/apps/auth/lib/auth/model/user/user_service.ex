defmodule Auth.Service.User do
  alias Auth.{Repo, Token}
  import Ecto.Query
  alias Auth.Model.User

  def update(id, map) do
    with {:ok, _id} <- Auth.not_nil(id, "id parametr not found"),
         {:ok, map} <- Auth.not_nil(map, "user parametr not found"),
         {:ok, vendor_sturct} <- User.get(id),
         {:ok, user} <-
           User.update_profile(vendor_sturct, map) do
      {:ok, user |> Map.delete(:password)}
    end
  end

  def login(login, password \\ "") do
    password = PwHelper.Hash.hash(password)

    query =
      from(
        user in User,
        where: user.login == ^login and user.password == ^password,
        select: [:id, :login, :email, :data, :is_registred, :roles, :location_id, :location_address]
      )

    user = Repo.one(query)

    cond do
      !is_nil(user) and !user.is_registred ->
        {:error, "Please check your email"}

      !is_nil(user) ->
        token = Token.generate_and_sign!(%{"user_id" => user.id, roles: user.roles})
        IO.inspect(user)
        {:ok, user, token}

      true ->
        {:error, "login or password not valid"}
    end
  end

  def register(email, password, repassword, login, _data, roles \\ ["tenant"], location) do
    case Repo.insert(
           User.changeset(%User{}, %{
             email: Ecto.UUID.generate(),
             password: password,
             repassword: password,
             login: login,
             is_registred: true,
             roles: roles,
             data: %{"img" => "", "name" => ""},
             location_id: location["location_id"],
             location_address: location["address"]
           })
         ) do
      {:ok, struct} ->
        token = Token.generate_and_sign!(%{"user_id" => struct.id, roles: roles})

        user = struct |> Map.delete(:password) |> Map.delete(:repassword)
        {:ok, user, token}

      {:error, reason} ->
        nil
        {:error, reason}
    end
  end

  def register_email_with_email(email, password, repassword, login, data, func_email, location)
      when is_function(func_email) do
    with {:ok, user, token} <- register(email, password, repassword, login, data, location),
         {:ok, confirm_struct} <-
           Auth.Model.Confirm.add(%{
             user_id: user.id,
             number: Auth.generate_numbers(9999, 9_999_999)
           }) do
      func_email.(%{user: user, confirm: confirm_struct})
      {:ok, user, token}
    end
  end

  def get_user_by_token(token) do
    with {:ok, claims} <- Token.verify_and_validate(token),
         {:ok, user} <- User.get(claims["user_id"]) do
      user = user |> Map.delete(:password)
      {:ok, user}
    end
  end

  def search_by_login(login) do
    login = "#{login}%"

    from(
      user in User,
      where: like(user.login, ^login),
      select: [:id, :login, :email, :data]
    )
    |> Repo.all([])
  end

  def get_all_users_by_list(list) do
    from(
      user in User,
      where: user.id in ^list,
      select: [:id, :login, :email, :data]
    )
    |> Repo.all([])
  end

  def get_by(login, :login) do
    from(
      user in User,
      where: user.login == ^login,
      select: [:id, :login, :email, :data]
    )
    |> Repo.one()
    |> Auth.not_found()
  end

  def query_get_by(id) do
    from(
      user in User,
      where: user.id == ^id,
      select: [:id, :login, :email, :data]
    )
  end

  def get_by(email, :email) do
    from(
      user in User,
      where: user.email == ^email,
      select: [:id, :login, :email, :data]
    )
    |> Repo.one()
    |> Auth.not_found()
  end

  def get_by(id) do
    from(
      user in User,
      where: user.id == ^id,
      select: [:id, :login, :email, :data]
    )
    |> Repo.one([])
    |> Auth.not_found()
  end
end
