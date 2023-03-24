defmodule BoomWeb.ImageController do
  @moduledoc """
  # IMAGE -> CREATE/GET BY ID/ALL
  """
  use BoomWeb, :controller
  action_fallback(BoomWeb.FallbackController)
  alias Boom.Service.Image, as: ServiceImage
  alias Boom.Model.Image

  @doc """
  # CREATE IMAGE
  """
  @doc auth: "token"
  def create(%{assigns: assign}, params) do
    IO.inspect(params)

    with {:ok, image} <-
           ServiceImage.create(assign.user_id, params["img"] || params["file"], params) do
      {:render, %{image: image}}
    end
  end

  @doc """
  # ALL IMAGE BY USER ID
  """
  @doc auth: "token"
  @doc params: %{
         page: "1",
         search_value: %{
           value: "",
           description: "Поиск по имени изображения"
         },
         table_type: "global",
         limit: "10"
       }
  def all(%{assigns: assign}, params) do
    with {:ok, image, count} <-
           ServiceImage.get_all(
             assign.user_id,
             params["page"],
             params["search_value"],
             params["table_img"] || "global",
             params["table_type"] || "global",
             params["limit"]
           ) do
      {:render, %{images: image, count: count}}
    end
  end

  @doc """
  # RANDOM IMAGE

  """
  @doc auth: "token"
  @doc params: %{
         img: ""
       }
  def random(_conn, _params) do
    with {:ok, images} <- File.ls("apps/boom_web/priv/static/images/anime") do
      image = Enum.random(images)

      {:render, %{image: ServiceImage.generate_url("images/anime/" <> image)}}
    end
  end
end
