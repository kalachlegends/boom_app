defmodule Auth.Plug do
  import Plug.Conn
  alias Auth.Token
  def init(options), do: options

  def call(conn, opts \\ %{}) do
    auth = get_req_header(conn, "authorization")
    roles = opts[:roles] || []

    if auth != [] do
      token =
        hd(auth)
        |> String.replace("Bearer ", "")

      user_ip =
        conn.remote_ip
        |> :inet.ntoa()
        |> to_string

      case Token.verify_and_validate(token) do
        {:ok, claims} ->
          IO.inspect(claims)

          if Enum.any?(claims["roles"], fn x -> x in roles end) do
            conn
            |> assign(:is_auth, true)
            |> assign(:user_id, claims["user_id"])
            |> assign(:roles, claims["roles"])
            |> assign(:client_ip, user_ip)
          else
            assign(conn, :is_auth, false)
            |> assign(:client_ip, user_ip)

            resp_message(conn, %{status: "error", message: "Your role is not appropriate"})
          end

        {:error, _err} ->
          resp_message(conn, %{status: "error", message: "Auth token not valid"})
      end
    else
      resp_message(conn, %{status: "error", message: "Auth token not find"})
    end
  end

  defp resp_message(conn, map_message) do
    map_message = map_message |> Jason.encode!()

    put_resp_content_type(conn, "application/json; charset=utf-8")
    |> send_resp(401, map_message)
    |> halt()
  end
end
