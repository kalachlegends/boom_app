defmodule Boom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp poolboy_config do
    [
      name: {:local, :async},
      worker_module: Boom.GenServer.Async,
      size: 5,
      max_overflow: 2
    ]
  end

  @impl true
  def start(_type, _args) do
    children = [
      Boom.Repo,
      Boom.Smtp.Mail,
      # Start the PubSub system
      {Phoenix.PubSub, name: Boom.PubSub},
      # Start a worker by calling: Boom.Worker.start_link(arg)
      # {Boom.Worker, arg}
      Boom.EtsStorage.ViewsStorage,
      # Boom.GenServer.Async,
      :poolboy.child_spec(:async, poolboy_config())
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Boom.Supervisor)
  end
end
