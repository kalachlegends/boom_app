defmodule BoomWeb.MoneyMovementController do
  @moduledoc """
  # Create moneymovement -> CRUD
  """
  @body %{
    locations_list: "",
    title: "",
    user_id: ""
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
    with {:ok, item} <- MoneyMovement.create(params |> Helper.map_put_user_id(conn)),
         {:ok, struct} <- Boom.Model.MoneyService.interact_with_money(item) do
      {:render, %{moneymovement: item}}
    end
  end

  @doc """
  # Update moneymovement
  """
  @doc body: @body
  @doc auth: "token"
  def update(conn, params) do
    with {:ok, item} <-
           MoneyMovement.update_by_id(params["id"], params |> Helper.map_put_user_id(conn)) do
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

  def get_mm_by_period(conn, params) do
    start_date =
      if is_nil(params["start_date"]) and params["start_date"] == "",
        do: nil,
        else: NaiveDateTime.from_iso8601!(params["start_date"]) |> NaiveDateTime.to_date()

    end_date =
      if is_nil(params["end_date"]) and params["end_date"] == "",
        do: nil,
        else: NaiveDateTime.from_iso8601!(params["end_date"]) |> NaiveDateTime.to_date()

    with {:ok, list} <-
           Boom.Model.MoneyService.get_mm_by_period(%{start_date: start_date, end_date: end_date}) do
      {:render, %{moneymovement: list}}
    end
  end
end
