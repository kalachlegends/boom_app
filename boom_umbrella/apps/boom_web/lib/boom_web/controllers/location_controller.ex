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
      {:render, %{locations: locations}}
    end
  end
end
