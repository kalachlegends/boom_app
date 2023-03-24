defmodule Auth.Plug.BruteForce do
  alias Auth.EtsStorage.BruteForce
  import Plug.Conn
  def init(options), do: options

  def call(conn, opts \\ %{}) do
    count = opts[:counts] || 15
    seconds = opts[:time_seconds] || 60 * 2

    client_ip =
      conn.remote_ip
      |> :inet.ntoa()
      |> to_string

    if !BruteForce.check_brote_force?(client_ip, conn.request_path, count, seconds) do
      conn
    else
      conn
      |> resp_message(%{
        status: "error",
        errors: "Too Many Requests"
      })
    end
  end

  defp resp_message(conn, map_message) do
    map_message = map_message |> Jason.encode!()

    put_resp_content_type(conn, "application/json; charset=utf-8")
    |> send_resp(429, map_message)
    |> halt()
  end
end
