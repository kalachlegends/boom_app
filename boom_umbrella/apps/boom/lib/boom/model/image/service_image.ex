defmodule Boom.Service.Image do
  import Ecto.Query

  alias Boom.Repo
  alias Boom.Model.Image
  require PwHelper.Error

  def create(map) do
    Image.changeset(%Image{}, map)
    |> Repo.insert()
  end

  def create(user_id, img, params) do
    cond do
      is_list(img) ->
        {Enum.each(img, fn x -> create(:create, user_id, x, params) end), "list_is_upload"}

      true ->
        create(:create, user_id, img, params)
    end
  end

  defp create(:create, user_id, img, params) do
    with {:ok, path, path_img, img, name} <-
           upload_image(user_id, img) |> PwHelper.Error.return_throw(),
         {:ok, image} <-
           create(
             %{
               "user_id" => user_id,
               "image_url" => path,
               "content_type" => img.content_type,
               "path" => path_img,
               "name" => name
             }
             |> Map.merge(params)
           ) do
      {:ok, image |> Map.delete(:path)}
    end
  end

  defp upload_image(user_id, img) do
    IO.inspect(img)
    if !Regex.match?(~r/image/, img.content_type), do: throw({:error, "File must be an image"})

    if upload = img do
      extension = Path.extname(upload.filename)
      img_url = "uploads/user=#{user_id}-#{Ecto.UUID.generate()}#{extension}"
      path = "apps/boom_web/priv/" <> img_url

      {File.cp(upload.path, path), generate_url("") <> img_url, path, img, upload.filename}
    else
      {:error, "file_is_nil"}
    end
  end

  def generate_url(path) do
    endpoint_cnf = Application.get_env(:boom_web, BoomWeb.Endpoint)
    url = endpoint_cnf[:url][:host]

    if Mix.env() == :dev do
      "http://" <> url <> ":#{endpoint_cnf[:http][:port]}" <> "/" <> path
    else
      "https://" <> url <> "/" <> path
    end
  end

  def get_all(user_id, page, search_name, type_img, table_type, limit \\ 10) do
    search_name = "%#{search_name}%"

    {images, count} =
      from(
        img in Image,
        where:
          img.user_id == ^user_id and like(img.name, ^search_name) and
            img.table_type == ^table_type and img.type_img == ^type_img,
        order_by: img.updated_at
      )
      |> Repo.pagination(page, limit)

    images = Repo.all(images, [])
    if [] != images, do: {:ok, images, count}, else: {:error, :not_found}
  end
end
