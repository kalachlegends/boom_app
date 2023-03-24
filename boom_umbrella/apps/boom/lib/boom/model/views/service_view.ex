defmodule Boom.Service.Views do
  # alias Boom.Repo
  # import Ecto.Query
  # import Ecto.Changeset

  # map => [parent_id]
  alias Boom.EtsStorage.ViewsStorage
  alias Boom.Service.Views
  alias Boom.Model.Views

  def add_counts_viewed_uniq(parent_id) do
    with {:ok, item} <- Views.get(%{parent_id: parent_id}),
         {:ok, item_update} <-
           Views.update(item, %{counts_viewed_uniq: item.counts_viewed_uniq + 1}) do
      {:ok, item_update}
    end
  end

  def add_counts_viewed_unkown(parent_id) do
    with {:ok, item} <- Views.get(%{parent_id: parent_id}),
         {:ok, item_update} <-
           Views.update(item, %{
             counts_viewed_unkown: item.counts_viewed_unkown + 1
           }) do
      {:ok, item_update}
    end
  end

  def count_control(%{parent_id: parent_id, client_ip: client_ip}) do
    Task.async(fn ->
      case ViewsStorage.check_view_client_ip(parent_id, client_ip) do
        :first ->
          add_counts_viewed_uniq(parent_id)

        :actual ->
          add_counts_viewed_unkown(parent_id)

        :expired ->
          nil
      end
    end)
  end
end
