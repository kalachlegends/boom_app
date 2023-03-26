defmodule BoomWeb.IncidentController do
  @moduledoc """
  # Create incident -> CRUD
  """
  @body %{
    close_dateq: "utc_datetime",
    description: "string",
    location_address: "string",
    location_id: "integer",
    priority: "string",
    status: "string",
    title: "string",
    user_id: "binary_id",
    org_id: "id"
  }

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.Incident
  alias Boom.Service.Incident, as: IncidentService
  alias Boom.Helper

  @doc """
  # Create incident
  """
  @doc body: @body
  @doc auth: "token"
  # Timex.from_unix(params["close_dateq"], :millisecond)
  def create(conn, params) do
    with {:ok, item} <-
           Incident.create(params |> Helper.map_put_user_id(conn)) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Update incident
  """
  @doc body: @body
  @doc auth: "token"
  def update(conn, params) do
    with {:ok, item} <-
           Incident.update_by_id(
             params["id"],
             params |> Helper.map_put_user_id(conn) |> Map.delete("close_dateq")
           ) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Get by attrs incident
  """
  @doc params: @body
  @doc auth: "token"
  def get_by_attrs(conn, params) do
    with {:ok, item} <- Incident.get(params) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Get_all by attrs incident
  """
  @doc params: @body
  @doc auth: "token"
  def get_all(conn, params) do
    with {:ok, item} <- Incident.get_all(params) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Get incident
  """
  @doc auth: "token"
  def get(conn, params) do
    with {:ok, item} <- Incident.get(params["id"]) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Delete incident
  """
  @doc auth: "token"
  def delete(conn, params) do
    with {:ok, item} <- Incident.delete(params["id"]) do
      {:render, %{incident: item}}
    end
  end

  def update_from_manger(conn, params) do
    opts = %{}
  end

  def update_from_org(conn, params) do
    opts = %{}
  end
end
