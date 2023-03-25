defmodule BoomWeb.IncidentController do
  @moduledoc """
  # Create incident -> CRUD
  """
  @body %{
  close_dateq: "",
  description: "",
  location_address: "",
  location_id: "",
  priority: "",
  status: "",
  title: "",
  user_id: "",
  org_id: ""
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
  def create(conn, params) do
    with {:ok, item} <- Incident.create(params |> Helper.map_put_user_id(conn)) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Update incident
  """
  @doc body: @body
  @doc auth: "token"
  def update(conn, params) do
    with {:ok, item} <- Incident.update_by_id(params["id"], params |> Helper.map_put_user_id(conn)) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Get by attrs incident
  """
  @doc body: @body
  @doc auth: "token"
  def get_by_attrs(conn, params) do
    with {:ok, item} <- Incident.get(params) do
      {:render, %{incident: item}}
    end
  end

  @doc """
  # Get_all by attrs incident
  """
  @doc body: @body
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
end
