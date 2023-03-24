defmodule BoomWeb.ConfirmController do
  @moduledoc """
  # Confrim ->
  """

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)
  alias Auth.Model.Confirm
  alias Boom.Helper
  alias Auth.Service.User, as: UserService
  alias Auth.Service.Confirm, as: ConfirmService
  @doc auth: "token"
  def get(_conn, params) do
    with {:ok, item} <-
           Confirm.get(%{id: params["id"], number: params["number"], confirmed: true}) do
      {:render, %{confrim: item}}
    end
  end

  @doc """
  # Link confirm email
  """
  def confirm_email(conn, params) do
    with :ok <- ConfirmService.confirm_user(params) do
      redirect(conn, external: Helper.get_frotend_path("/login"))
    else
      {:error, _} -> redirect(conn, external: Helper.get_frotend_path("/login"))
    end
  end

  @doc """
  # Request restore password
  """
  @doc body: %{
         email: "email"
       }
  def request_restore_password(conn, params) do
    with {:ok, item} <-
           UserService.get_by(params["email"], :email),
         {:ok, item_confirm} <- Confirm.add(user_id: item.id) do
      Boom.Smtp.Mail.send_restore_password(%{
        login: item.login,
        email: item.email,
        number: item_confirm.number,
        uuid: item_confirm.id
      })

      {:render, %{status: "ok"}}
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
          Helper.get_frotend_path(
            "/restore_password/restore?request=#{confirm.id}&request2=#{confirm.number}"
          )
      )
    else
      {:error, _} ->
        redirect(conn,
          external: Helper.get_frotend_path("/errors/old_link")
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
end
