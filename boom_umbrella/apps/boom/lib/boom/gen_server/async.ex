defmodule Boom.GenServer.Async do
  use GenServer
  require Logger

  def init(_attrs) do
    {:ok, %{}}
  end

  def start_link(attrs), do: GenServer.start_link(__MODULE__, attrs)

  def handle_cast({:async, func, meta}, state) do
    IO.puts("process #{inspect(self())} ")

    try do
      case func.() do
        {:ok, _} ->
          Logger.info("SUCSESS ASYNC: #{meta}")
          {:noreply, state}

        {:error, _} ->
          Logger.error("ERROR ASYNC: #{meta}")
          {:noreply, state}

        _ ->
          Logger.info("UNKOWN ASYNC: #{meta} ")
          {:noreply, state}
      end
    rescue
      _ ->
        Logger.error("ERROR TRY DO ASYNC: #{meta} ")
        {:noreply, state}
    end
  end

  def async_request(func, meta \\ "NOT FOUND ASYNC META")
      when is_function(func) and is_bitstring(meta) do
    :poolboy.transaction(
      :async,
      fn pid ->
        IO.inspect(pid)

        try do
          GenServer.cast(pid, {:async, func, meta})
        catch
          e, r ->
            :ok
        end
      end,
      10_000
    )
  end

  def terminate(_reason, state) do
    Logger.error("TERMINATE #{__MODULE__}")

    {:normal, state}
  end
end
