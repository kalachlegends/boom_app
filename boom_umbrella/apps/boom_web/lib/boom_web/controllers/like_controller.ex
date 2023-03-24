defmodule BoomWeb.LikeController do
  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)

  @moduledoc """
  # LIKE -> like
  """
  # alias Boom.Model.UserLikes
  alias Boom.Service.UserLikes, as: UserLikesService
  alias Boom.Model.Like

  @doc """
  # REQUEST LIKE

  """
  @doc body: %{
         type_like: "like",
         parent_id: "write id",
         type_parent: "novella"
       }
  @doc auth: "token"
  def like(%{assigns: %{user_id: user_id}}, params) do

    with {:ok, like_item, user} <-
           UserLikesService.like(
             user_id,
             params["type_like"],
             params["parent_id"],
             params["type_parent"]
           ) do
      {:ok, like_item} = like_item
      {:render, %{like_item: like_item, user: user}}
    end
  end

  @doc """
  # GET LIKE BY PARENT ID

  """

  @doc params: %{
         type_parent: "novella",
         parent_id: "write_id"
       }
  @doc auth: "token"
  def get_like_by_id(_conn, params) do
    with {:ok, like} <-
           Like.get(%{type_parent: params["type_parent"], parent_id: params["parent_id"]}) do
      {:render, %{like: like}}
    end
  end

  def info(%{}) do
  end
end
