defmodule BoomWeb.MoneyController do
  @moduledoc """
  # Create money -> CRUD
  """
  @body %{
    org_id: "binary_id",
    cash: "map",
    type: "string",
    movement: "integer",
    attrs: %{}
  }

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.Money
  alias Boom.Service.Money, as: MoneyService
  alias Boom.Helper

  @doc """
  # Create money
  """
  @doc body: @body
  @doc auth: "token"
  def create(conn, params) do
    with {:ok, item} <- Money.create(params |> Helper.map_put_user_id(conn)) do
      {:render, %{money: item}}
    end
  end

  @doc """
  # Update money
  """
  @doc body: @body
  @doc auth: "token"
  def update(conn, params) do
    with {:ok, item} <- Money.update_by_id(params["id"], params |> Helper.map_put_user_id(conn)) do
      {:render, %{money: item}}
    end
  end

  @doc """
  # Get by attrs money
  """
  @doc params: @body
  @doc auth: "token"
  def get_by_attrs(conn, params) do
    with {:ok, item} <- Money.get(params) do
      {:render, %{money: item}}
    end
  end

  @doc """
  # Get_all by attrs money
  """
  @doc params: @body
  @doc auth: "token"
  def get_all(conn, params) do
    with {:ok, item} <- Money.get_all(params) do
      {:render, %{money: item}}
    end
  end

  @doc """
  # Get money
  """
  @doc auth: "token"
  def get(conn, params) do
    with {:ok, item} <- Money.get(params["id"]) do
      {:render, %{money: item}}
    end
  end

  @doc """
  # Delete money
  """
  @doc auth: "token"
  def delete(conn, params) do
    with {:ok, item} <- Money.delete(params["id"]) do
      {:render, %{money: item}}
    end
  end

  def get_by_org_id(conn, params) do
    with {:ok, list} <- Boom.Model.MoneyService.get_money_by_org_id(params["org_id"]) do
      {:render, %{money: list}}
    end
  end

  # def create_money_movement(conn, params) do
  #   with  <- Boom.Model.MoneyMovement.create() do

  #   end
  # end
end
