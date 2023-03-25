defmodule BoomWeb.LocationController do
  @moduledoc """
  # Create location -> CRUD
  """
  @params %{
    sample: "Караганда"
}

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.Location
  alias Boom.Service.Location, as: LocationService

  @doc """
  # Get location by sample name
  """
  @doc params: @params
  @doc auth: "token"
  def get_by_sample(_conn, params) do
    with {:ok, locations} <- LocationService.get_by_sample(params) do
      {:render, %{locations: Enum.map(locations, &Map.put(&1, :full_name, String.replace(&1.full_name, "Республика Казахстан ", "")))}}
    end
  end
end
