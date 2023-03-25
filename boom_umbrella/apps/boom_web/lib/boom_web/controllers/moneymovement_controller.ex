defmodule BoomWeb.MoneyMovementController do
  @moduledoc """
  # Create moneymovement -> CRUD
  """
  @body %{
  locations_list: "",
  title: "",
  user_id: "",

}

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.MoneyMovement
  alias Boom.Service.MoneyMovement, as: MoneyMovementService
  alias Boom.Helper
  @doc """
  # Create moneymovement
  """
  @doc body: @body
  @doc auth: "token"
  def create(conn, params) do
    with {:ok, item} <- MoneyMovement.create(params |> Helper.map_put_user_id(conn)) do
      {:render, %{moneymovement: item}}
    end
  end

  @doc """
  # Update moneymovement
  """
  @doc body: @body
  @doc auth: "token"
  def update(conn, params) do
    with {:ok, item} <- MoneyMovement.update_by_id(params["id"], params |> Helper.map_put_user_id(conn)) do
      {:render, %{moneymovement: item}}
    end
  end

  @doc """
  # Get by attrs moneymovement
  """
  @doc params: @body
  @doc auth: "token"
  def get_by_attrs(conn, params) do
    with {:ok, item} <- MoneyMovement.get(params) do
      {:render, %{moneymovement: item}}
    end
  end

  @doc """
  # Get_all by attrs moneymovement
  """
  @doc params: @body
  @doc auth: "token"
  def get_all(conn, params) do
    with {:ok, item} <- MoneyMovement.get_all(params) do
      {:render, %{moneymovement: item}}
    end
  end

  @doc """
  # Get moneymovement
  """
  @doc auth: "token"
  def get(conn, params) do
    with {:ok, item} <- MoneyMovement.get(params["id"]) do
      {:render, %{moneymovement: item}}
    end
  end

  @doc """
  # Delete moneymovement
  """
  @doc auth: "token"
  def delete(conn, params) do
    with {:ok, item} <- MoneyMovement.delete(params["id"]) do
      {:render, %{moneymovement: item}}
    end
  end
end
