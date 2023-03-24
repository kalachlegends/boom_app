defmodule Auth.GenServer.DeleteUsers do
  @time_to_sleep 1000 * 60 * 60 * 24
  use GenServer
  require Logger
  alias Auth.Service.Confirm

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args], name: __MODULE__)
  end

  def init(_args) do
    clear()
    {:ok, :initial_state}
  end

  @impl true
  def handle_cast({:clear}, state) do
    Process.sleep(@time_to_sleep)
    Confirm.remove_users_without_registed()
    clear()
    {:noreply, state}
  end

  def clear() do
    GenServer.cast(__MODULE__, {:clear})
  end
end
