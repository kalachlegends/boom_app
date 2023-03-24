defmodule Auth.EtsStorage.BruteForce do
  @table_name :brute_force_storage
  @time_to_sleep 1000 * 60 * 30
  require Logger
  import Ex2ms
  use GenServer

  def init(attrs) do
    GenServer.cast(__MODULE__, {:reset})
    reset()
    {:ok, attrs}
  end

  def start_link(attrs) do
    :ets.new(
      @table_name,
      [
        :set,
        :public,
        :named_table
      ]
    )

    GenServer.start_link(__MODULE__, attrs, name: __MODULE__)
  end

  def handle_cast({:reset}, state) do
    Process.sleep(@time_to_sleep)
    Logger.info("CLEAR #{@table_name} STORAGE")
    reset()
    :ets.delete_all_objects(@table_name)
    {:noreply, state}
  end

  def get_by_id(id) do
    case :ets.lookup(@table_name, id) do
      [item] -> item
      [] -> {:error, :not_found}
    end
  end

  def insert(ip, route) do
    :ets.insert_new(@table_name, {Ecto.UUID.generate(), ip, route, 0, Timex.now()})
  end

  def get_by_ip_and_route(ip, route) do
    :ets.select(
      @table_name,
      fun do
        {_, ip_ets, route_ets, _, _} = item when ip_ets == ^ip and ^route == route_ets ->
          item
      end
    )
  end

  def check_brote_force?(ip, route, count_check \\ 10, time_diff_seconds \\ 60) do
    case get_by_ip_and_route(ip, route) do
      [item] ->
        {id, ip, route, count, time} = item

        if count_check >= count do
          new_item = {id, ip, route, count + 1, time}
          insert_or_delete_by_time(new_item, time_diff_seconds)
          false
        else
          Logger.info("HAVE TO MANY REQUEST IP -> #{ip}, ROUTE -> #{route}, COUNT -> #{count}")
          insert_or_delete_by_time(item, time_diff_seconds, false)
        end

      [] ->
        insert(ip, route)
        false
    end
  end

  def insert_or_delete_by_time(
        {id, _ip, _route, _count, time} = item,
        time_diff,
        is_count \\ true
      ) do
    if Time.diff(Timex.now(), time) <= time_diff do
      if is_count, do: :ets.insert(@table_name, item)

      true
    else
      :ets.delete(@table_name, id)
      false
    end
  end

  defp reset() do
    GenServer.cast(__MODULE__, {:reset})
  end
end
