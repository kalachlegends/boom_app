defmodule BoomWeb.UserController do
  use BoomWeb, :controller
  alias Auth.Service.User
  alias Auth.Model.Confirm
  alias Auth.Service.Confirm, as: ConfirmService

  @moduledoc """
  # User -> LOGIN/REGISTER/AUTH_ME/SEARCH_LOGIN

  LOGIN/REGISTER/AUTH_ME/SEARCH_KI
  """
  action_fallback BoomWeb.FallbackController

  @doc """
  # REGISTER
  """
  @doc auth: "token"
  @doc body: %{
         login: "test",
         email: "test@gmail.com",
         password: "1234",
         repassword: "1234"
       }
  def register(_conn, params) do
    IO.inspect(params)
    with {:ok, struct, token} <-
           User.register(
             params["email"],
             params["password"],
             params["repassword"],
             params["login"],
             params["data"],
             params["roles"],
             params["location"]
           ) do
      {:render, %{user: struct, token: token, message: "Check Email"}}
    end
  end

  @doc """
  # LOGIN
  """
  @doc body: %{
         login: "test",
         password: "1234"
       }
  @doc auth_pre_request: %{
         is_enabled: true
       }
  def login(_conn, params) do
    with {:ok, struct, token} <- User.login(params["login"], params["password"]) do
      {:render, %{token: token, user: struct}}
    end
  end

  @doc """
  # Link accept restore password
  """
  def link_accept_restore(conn, params) do
    with {:ok, item} <-
           Confirm.get(%{id: params["id"], number: params["number"]}),
         {:ok, confirm} <- Confirm.update(item, %{confirmed: true}) do
      redirect(conn,
        external:
          "http://novella-designer.com/restore_password?request=#{confirm.id}&request2=#{confirm.number}"
      )
    else
      {:error, _} ->
        redirect(conn,
          external: "http://novella-designer.com/errors/old_link"
        )
    end
  end

  @doc body: %{
         password: "1234",
         confirm_id: "",
         number: ""
       }
  @doc """
  # Post restore password
  """
  def restore_password(_conn, params) do
    with {:ok, token_and_user} <- ConfirmService.restore_password(params) do
      {:render, token_and_user}
    end
  end

  @doc """
  # AUTH ME
  """
  @doc auth: "token"
  def auth_me(%{assigns: assigns}, params) do
    {:render, %{params: params, assigns: assigns}}
  end

  @doc """
  # GET USER LOGIN BY LOGIN
  """
  def get_profile(_conn, %{"login" => login}) do
    with {:ok, user} <- User.get_by(login, :login) do
      {:render, %{user: user}}
    end
  end

  @doc """
  # GET BY ID
  """
  def get_by_id(_conn, %{"id" => id}) do
    with {:ok, user} <- User.get_by(id) do
      {:render, %{user: user}}
    end
  end

  @doc """
  # SEARCH BY LOGIN
  """
  @doc auth: "token"
  def search_by_login(_conn, %{"login" => login}) do
    with user <- User.search_by_login(login) do
      {:render, %{users: user}}
    end
  end

  @doc """
  # PROFILE EDIT
  """
  @doc auth: "token"
  @doc body: %{
         todo: "todo"
       }
  def profile_edit(%{assigns: %{user_id: user_id}}, %{"user" => user}) do
    with {:ok, user} <- User.update(user_id, user) do
      {:render, %{user: user}}
    end
  end
end
