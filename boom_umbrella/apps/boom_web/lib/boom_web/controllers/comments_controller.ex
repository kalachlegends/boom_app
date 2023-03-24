defmodule BoomWeb.CommentsController do
  @moduledoc """
  # Create comments -> CRUD
  """
  @body %{
    parent_id: "",
    table_type: "",
    body: "",
    user_id: "",
    comments_id: ""
  }

  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  alias Boom.Model.Comments
  alias Boom.Service.Comments, as: CommentsService

  @doc """
  # Create comments
  """
  @doc body: @body
  @doc token: "token"
  def create(_conn, params) do
    with {:ok, item} <- Comments.create(params) do
      {:render, %{comments: item}}
    end
  end

  @doc """
  # Update comments
  """
  @doc body: @body
  @doc token: "token"
  def update(_conn, params) do
    with {:ok, item} <- Comments.update_by_id(params["id"], params) do
      {:render, %{comments: item}}
    end
  end

  @doc """
  # Get by attrs comments
  """
  @doc body: @body
  @doc token: "token"
  def get_by_attrs(_conn, params) do
    with {:ok, item} <- Comments.get(params) do
      {:render, %{comments: item}}
    end
  end

  @doc """
  # Get_all by attrs comments
  """
  @doc body: @body
  @doc token: "token"
  def get_all(_conn, params) do
    with {:ok, item} <- Comments.get_all(params) do
      {:render, %{comments: item}}
    end
  end

  @doc """
  # Get comments
  """
  @doc token: "token"
  def get(_conn, params) do
    with {:ok, item} <- Comments.get(params["id"]) do
      {:render, %{comments: item}}
    end
  end

  @doc """
  # Delete comments
  """
  @doc token: "token"
  def delete(_conn, params) do
    with {:ok, item} <- Comments.delete(params["id"]) do
      {:render, %{comments: item}}
    end
  end
end
