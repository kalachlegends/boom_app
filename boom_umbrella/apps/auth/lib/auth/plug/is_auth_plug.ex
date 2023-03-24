defmodule Auth.Plug.IsAuth do
  import Plug.Conn
  alias Auth.Token

  def init(options), do: options

  def call(conn, _opts \\ %{}) do
    auth = get_req_header(conn, "authorization")

    if auth != [] do
      token =
        hd(auth)
        |> String.replace("Bearer ", "")

      client_ip =
        conn.remote_ip
        |> :inet.ntoa()
        |> to_string

      case Token.verify_and_validate(token) do
        {:ok, claims} ->
          conn
          |> assign(:is_auth, true)
          |> assign(:user_id, claims["user_id"])
          |> assign(:client_ip, client_ip)

        {:error, _err} ->
          assign(conn, :is_auth, false)
          |> assign(:client_ip, client_ip)

          # resp_message(conn, %{status: "error", message: "Auth token not valid"})
      end
    else
      client_ip =
        conn.remote_ip
        |> :inet.ntoa()
        |> to_string

      assign(conn, :is_auth, false)
      |> assign(:client_ip, client_ip)

      # resp_message(conn, %{status: "error", message: "Auth token not find"})
    end
  end
end
