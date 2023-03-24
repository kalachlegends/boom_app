defmodule BoomWeb.ViewsController do
  @moduledoc """
  # Views -> CRUD
  """

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.Views
  # alias Boom.Service.Views, as: ViewsService

  @doc """
  # Get by attrs views
  """
  @doc body: %{
         parent_id: "write_id",
         table_type: "views"
       }
  @doc token: "token"
  def get_by_attrs(_conn, params) do
    with {:ok, item} <- Views.get(params) do
      {:render, %{views: item}}
    end
  end

  @doc """
  # Get_all by attrs views
  """
  @doc body: %{
         parent_id: "write_id",
         table_type: "views"
       }
  @doc token: "token"
  def get_all(_conn, params) do
    with {:ok, item} <- Views.get_all(params) do
      {:render, %{views: item}}
    end
  end

  @doc """
  # Get views
  """
  @doc token: "token"
  def get(_conn, params) do
    with {:ok, item} <- Views.get(params["id"]) do
      {:render, %{views: item}}
    end
  end
end
