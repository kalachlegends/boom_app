defmodule Manuscript.Application do
  @moduledoc """
  # Точка входа
  """
  use Application

  @impl true
  def start(_type, _args) do
    is_server = Application.get_env(Manuscript, :server)
    port = Application.get_env(Manuscript, :port) || 10102

    children =
      if !is_nil(is_server) and is_server do
        :logger.info("""
        Manusript Start Server on port: #{port}
        Server -> http://localhost:#{port}/
        """)

        [
          {Plug.Cowboy, scheme: :http, plug: Manuscript.Server, options: [port: port]}
        ]
      else
        []
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Manuscript.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
