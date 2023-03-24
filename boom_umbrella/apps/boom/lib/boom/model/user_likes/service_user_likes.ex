defmodule Boom.Service.UserLikes do
  alias Boom.Model.UserLikes
  alias Boom.Model.Like
  import Ecto.Query
  require PwHelper.Error
  require Logger

  def like(user_id, type_like, parent_id, type_parent) do
    func = fn ->
      like = Like.get!(parent_id: parent_id)
      PwHelper.Error.throw_is_nil(like, "like_not_found")

      UserLikes.get(parent_id: parent_id, user_id: user_id)
      |> case do
        {:ok, user} ->
          type_like =
            if (user.type_like == :like and type_like == "like") or
                 (user.type_like == :dis_like and type_like == "dis_like") do
              "not_like"
            else
              type_like
            end

          like_item = like_by_type(like, type_like, user.type_like, true)

          UserLikes.update_by_opts(user.id, %{
            parent_id: parent_id,
            type_like: type_like,
            type_parent: type_parent,
            user_id: user_id
          })

          {:ok, like_item, user}

        {:error, _reason} ->
          {:ok, user} =
            UserLikes.create(%{
              parent_id: parent_id,
              type_like: type_like,
              type_parent: type_parent,
              user_id: user_id
            })

          like_item = like_by_type(like, type_like, user.type_like, false)
          {:ok, like_item, user}
      end
    end

    func.()
    |> PwHelper.Error.return_throw()
  end

  defp like_by_type(item_like, type_like, user_type, is_user_like) do
    cond do
      type_like == "like" and !is_user_like ->
        Like.update(item_like, %{counts_like: item_like.counts_like + 1})

      type_like == "dis_like" and !is_user_like ->
        Like.update(item_like, %{counts_dis_like: item_like.counts_dis_like + 1})

      type_like == "like" and user_type == :dis_like and is_user_like ->
        Like.update(item_like, %{
          counts_like: item_like.counts_like + 1,
          counts_dis_like: item_like.counts_dis_like - 1
        })

      type_like == "dis_like" and user_type == :like and is_user_like ->
        Like.update(item_like, %{
          counts_like: item_like.counts_like - 1,
          counts_dis_like: item_like.counts_dis_like + 1
        })

      type_like == "not_like" and user_type == :like and is_user_like ->
        Like.update(item_like, %{
          counts_like: item_like.counts_like - 1
        })

      type_like == "not_like" and user_type == :dis_like and is_user_like ->
        Like.update(item_like, %{
          counts_dis_like: item_like.counts_dis_like - 1
        })

      type_like == "like" and user_type == :not_like and is_user_like ->
        Like.update(item_like, %{
          counts_like: item_like.counts_like + 1
        })

      type_like == "dis_like" and user_type == :not_like and is_user_like ->
        Like.update(item_like, %{
          counts_dis_like: item_like.counts_dis_like + 1
        })

      true ->
        throw({:error, "the user has " <> type_like})
    end
  end
end
