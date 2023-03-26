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

  import Ecto.Query
  alias Boom.Model.{Incident, Organization}
  alias Auth.Model.User
  alias Boom.Service.Incident, as: IncidentService
  alias Boom.Helper

  @doc """
  # Create incident
  """
  @doc body: @body
  @doc auth: "token"
  def create(conn, params) do
    # Timex.from_unix(params["close_dateq"], :millisecond)

    with {:ok, user} <- User.get(id: conn.assigns.user_id),
         org <-
           hd(
             Boom.Repo.all(from(o in Organization, where: ^user.location_id in o.locations_list))
           ),
         {:ok, item} <-
           Incident.create(params |> Map.put("location_id", user.location_id) |> Map.put("org_id", org.id) |> IO.inspect |> Helper.map_put_user_id(conn)) do
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
           Incident.update_by_id(params["id"], params |> Helper.map_put_user_id(conn)) do
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
