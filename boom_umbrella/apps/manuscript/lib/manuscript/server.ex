defmodule Manuscript.Server do
  use Plug.Router

  import Plug.Conn
  use Plug.Builder

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :manucriptl
  end

  plug(:boom)

  def boom(conn, erorr) do
    # Error raised here will be caught and displayed in a debug page
    # complete with a stacktrace and other helpful info.
    # raise erorr
    conn
  end

  alias Plug.Conn

  plug(Plug.Static, at: "/", from: :manuscript, only: ~w(css fonts js favicon.ico))

  plug(Plug.Session,
    store: :cookie,
    key: "_manuscript_key",
    signing_salt: "waRZhWJR",
    secret_key_base: "yFEh45jxC1He2K6iePafDjJtr2CLDI1aHcLxzD3JkG4+972i5Bbj8Gqx1e2DZWao"
  )

  get("/favicon.ico", do: Conn.send_file(conn, 200, "./lib/favicon.ico"))

  get "/" do
    conn
    |> fetch_session
    |> verify_app_token()
    |> render("index", data: Manuscript.Generator.generate_data())
  end

  get "/readme" do
    conn
    |> fetch_session
    |> render("readme")
  end

  get "/auth" do
    conn
    |> Conn.put_resp_content_type("text/html")
    |> render("auth")
  end

  post("/auth") do
    {:ok, app_key, conn} =
      conn
      |> read_body

    app_key = String.replace(app_key, "auth_key=", "")

    conn
    |> fetch_session()
    |> put_session(:app_key, app_key)
    |> verify_app_token()
    |> redirect("/")
  end

  get "/download" do
    with {:ok, file} <- Manuscript.Postman.generate() do
      conn
      |> Conn.put_resp_header("content-disposition", ~s(attachment; filename="#{file}"))
      |> Conn.send_file(200, file)
    end
  end

  plug(:match)
  plug(:dispatch)

  defp render(%{status: status} = conn, file_name, assigns \\ []) do
    body =
      file_path(file_name)
      |> EEx.eval_file(assigns)

    send_resp(conn, status || 200, body)
  end

  def verify_app_token(conn) do
    app_token =
      conn
      |> fetch_session()
      |> get_session(:app_key)

    if app_token == get_app_key() do
      conn
    else
      conn
      |> redirect("/auth")
    end
  end

  defp file_path(file_name) do
    __ENV__.file
    |> String.replace("server.ex", "#{file_name}.html.heex")
  end

  defp get_app_key() do
    Application.get_env(Manuscript, :app_key) || "secret1234"
  end

  # @impl Plug.ErrorHandler
  # def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
  #   IO.inspect(stack)
  #   send_resp(conn, conn.status, reason)
  # end

  def redirect(conn, url) do
    html = Plug.HTML.html_escape(url)
    body = "<html><body>You are being <a href=\"#{html}\">redirected</a>.</body></html>"

    conn
    |> Conn.put_resp_header("location", url)
    |> Conn.send_resp(conn.status || 302, body)
  end
end
