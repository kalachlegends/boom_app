defmodule BoomWeb.PostController do
  @moduledoc """
  # Create post -> CRUD
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

  alias Boom.Model.Post
  alias Boom.Service.Post, as: PostService

  @doc """
  # Create post
  """
  @doc body: @body
  @doc auth: "token"
  def create(_conn, params) do
    with {:ok, item} <- Post.create(params) do
      {:render, %{post: item}}
    end
  end

  @doc """
  # Update post
  """
  @doc body: @body
  @doc auth: "token"
  def update(_conn, params) do
    with {:ok, item} <- Post.update_by_id(params["id"], params) do
      {:render, %{post: item}}
    end
  end

  @doc """
  # Get by attrs post
  """
  @doc body: @body
  @doc auth: "token"
  def get_by_attrs(_conn, params) do
    with {:ok, item} <- Post.get(params) do
      {:render, %{post: item}}
    end
  end

  @doc """
  # Get_all by attrs post
  """
  @doc body: @body
  @doc auth: "token"
  def get_all(_conn, params) do
    with {:ok, item} <- Post.get_all(params) do
      {:render, %{post: item}}
    end
  end

  @doc """
  # Get post
  """
  @doc auth: "token"
  def get(_conn, params) do
    with {:ok, item} <- Post.get(params["id"]) do
      {:render, %{post: item}}
    end
  end

  @doc """
  # Delete post
  """
  @doc auth: "token"
  def delete(_conn, params) do
    with {:ok, item} <- Post.delete(params["id"]) do
      {:render, %{post: item}}
    end
  end
end
