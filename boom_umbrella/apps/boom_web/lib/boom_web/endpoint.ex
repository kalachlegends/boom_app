defmodule BoomWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :boom_web

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_boom_web_key",
    signing_salt: "OTuSBiuo"
  ]

  socket("/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]])

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :boom_web,
    gzip: false,
    only: ~w(assets  fonts images uploads favicon.ico robots.txt)
  )

  # plug(Plug.Static, at: "/media", from: :boom_web, only: ~w(media))
  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
    plug(Phoenix.Ecto.CheckRepoStatus, otp_app: :boom_web)
  end

  plug(Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"
  )

  plug(CORSPlug)

  plug(Plug.Static,
    at: "/",
    from: {:boom_web, "priv/app"},
    gzip: false,
    only: ~w(index.html manifest.json service-worker.js css fonts img js favicon.ico robots.txt),
    only_matching: ["precache-manifest"]
  )

  plug(Plug.Static,
    at: "/uploads/",
    gzip: false,
    from: {:boom_web, "priv/uploads"}
  )

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])

  plug(Plug.Parsers,
    parsers: [:urlencoded, {:multipart, length: 10_000_000}, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  plug(Plug.Session, @session_options)

  plug(BoomWeb.Router)
end
