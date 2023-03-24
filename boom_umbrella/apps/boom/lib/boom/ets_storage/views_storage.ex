defmodule Boom.EtsStorage.ViewsStorage do
  import Ex2ms
  require Logger
  use GenServer
  @table_name :storage_views_count
  @time_to_sleep 1000 * 60 * 30

  def init(attrs) do
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

  def insert(parent_id, client_ip) do
    :ets.insert_new(
      @table_name,
      {
        Ecto.UUID.generate(),
        parent_id,
        client_ip,
        0,
        Timex.now()
      }
    )
  end

  def get_by_ip_and_route(parent_id, client_ip) do
    :ets.select(
      @table_name,
      fun do
        {_, parent_id_ets, client_ip_ets, _, _} = item
        when parent_id_ets == ^parent_id and client_ip_ets == ^client_ip ->
          item
      end
    )
  end

  @spec check_view_client_ip(any, any, any, any) :: :actual | :expired | :first
  def check_view_client_ip(
        parent_id,
        client_ip,
        count_check \\ 30,
        time_diff_seconds \\ @time_to_sleep
      ) do
    case get_by_ip_and_route(parent_id, client_ip) do
      [item] ->
        {id, parent_id, client_ip, count, time} = item

        if count_check >= count do
          new_item = {id, parent_id, client_ip, count + 1, time}
          insert_or_delete_by_time(new_item, time_diff_seconds)
          :actual
        else
          insert_or_delete_by_time(item, time_diff_seconds, false)
          :expired
        end

      [] ->
        insert(parent_id, client_ip)
        :first
    end
  end

  def insert_or_delete_by_time(
        {id, _, _, _, time} = item,
        time_diff,
        is_count \\ true
      ) do
    if Time.diff(Timex.now(), time) <= time_diff do
      if is_count, do: :ets.insert(@table_name, item)

      false
    else
      :ets.delete(@table_name, id)
      false
    end
  end

  def handle_cast({:reset}, state) do
    Process.sleep(@time_to_sleep)
    Logger.info("CLEAR #{@table_name} STORAGE")
    :ets.delete_all_objects(@table_name)
    reset()
    {:noreply, state}
  end

  defp reset() do
    GenServer.cast(__MODULE__, {:reset})
  end
end
