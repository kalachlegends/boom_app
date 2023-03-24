defmodule Boom.Helper do
  def rundom_number do
    number = to_string(Enum.random(111_111..999_999))
    {:ok, number}
  end

  def get_dashboard_auth() do
    case System.fetch_env("AUTH_PASSWORD") do
      {:ok, password} ->
        password

      :error ->
        "localhost1211"
    end
  end

  def map_put_user_id(map, conn) when is_map(conn) do
    map
    |> Map.put("user_id", conn.assigns.user_id)
  end

  def map_put_user_id(map, user_id) when is_binary(user_id) do
    map
    |> Map.put("user_id", user_id)
  end

  def get_frotend_path(path \\ "") do
    Application.get_env(:boom_web, BoomWeb.Endpoint)[:frotend_url] <> path
  end
end
