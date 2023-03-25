defmodule Mix.Tasks.Gen.Controller do
  @moduledoc """
  # Генериует в контроллере и в роутере базовые операции
  ## Пример использования: `mix gen.controller Name`

  Генерирует в контролерее базовый темплейт CRUD'A"
  """
  @shortdoc "Generate template controller CRUD'A"
  use Mix.Task
  @application_path "/apps/boom_web/lib"
  @app_name "Boom"

  @impl Mix.Task
  def run(args) do
    case File.cwd() do
      {:ok, item} ->
        name = args |> hd()
        name_file_downcase = name |> String.downcase()

        file_name = name_file_downcase <> "_controller.ex"
        path = item <> "#{@application_path}/boom_web/controllers/" <> file_name
        {:ok, map} = File.read(item <> "#{@application_path}/mix/tasks/json.exs")

        :ok =
          File.write(
            path,
            generate_file(name, map)
          )

        generate_route(item, name)

        :ok =
          Mix.shell().info("""
          GENERATE ->>>>>>> #{path}
          """)

      {:error, reason} ->
        Mix.shell().error(reason)
    end
  end

  defp generate_route(path, name) do
    path = path <> "/apps/boom_web/lib/boom_web/router.ex"

    with {:ok, file} <- File.read(path) do
      file = String.replace(file, "# @generate", route_string(name))
      File.write(path, file)

      Mix.shell().info("""
      #{route_string(name)}
      GENERATE ROUTE ->>>>>>> #{path}
      """)
    end
  end

  defp route_string(name) do
    name_file_downcase = name |> String.downcase()

    """
      # @generate
        scope "/#{name_file_downcase}" do
          post("/", #{name}Controller, :create)
          get("/all", #{name}Controller, :get_all)
          get("/attrs", #{name}Controller, :get_by_attrs)
          get("/:id", #{name}Controller, :get)
          put("/", #{name}Controller, :update)
          delete("/:id", #{name}Controller, :delete)
       end
    """
  end

  def generate_file(name, map) do
    name_file_downcase = name |> String.downcase()

    """
    defmodule #{@app_name}Web.#{name}Controller do
      @moduledoc \"\"\"
      # Create #{name_file_downcase} -> CRUD
      \"\"\"
      @body #{map}
      use #{@app_name}Web, :controller
      action_fallback(#{@app_name}Web.FallbackController)

      alias #{@app_name}.Model.#{name}
      alias #{@app_name}.Service.#{name}, as: #{name}Service
      alias Boom.Helper
      @doc \"\"\"
      # Create #{name_file_downcase}
      \"\"\"
      @doc body: @body
      @doc auth: "token"
      def create(conn, params) do
        with {:ok, item} <- #{name}.create(params |> Helper.map_put_user_id(conn)) do
          {:render, %{#{name_file_downcase}: item}}
        end
      end

      @doc \"\"\"
      # Update #{name_file_downcase}
      \"\"\"
      @doc body: @body
      @doc auth: "token"
      def update(conn, params) do
        with {:ok, item} <- #{name}.update_by_id(params["id"], params |> Helper.map_put_user_id(conn)) do
          {:render, %{#{name_file_downcase}: item}}
        end
      end

      @doc \"\"\"
      # Get by attrs #{name_file_downcase}
      \"\"\"
      @doc body: @body
      @doc auth: "token"
      def get_by_attrs(conn, params) do
        with {:ok, item} <- #{name}.get(params) do
          {:render, %{#{name_file_downcase}: item}}
        end
      end

      @doc \"\"\"
      # Get_all by attrs #{name_file_downcase}
      \"\"\"
      @doc body: @body
      @doc auth: "token"
      def get_all(conn, params) do
        with {:ok, item} <- #{name}.get_all(params) do
          {:render, %{#{name_file_downcase}: item}}
        end
      end

      @doc \"\"\"
      # Get #{name_file_downcase}
      \"\"\"
      @doc auth: "token"
      def get(conn, params) do
        with {:ok, item} <- #{name}.get(params["id"]) do
          {:render, %{#{name_file_downcase}: item}}
        end
      end

      @doc \"\"\"
      # Delete #{name_file_downcase}
      \"\"\"
      @doc auth: "token"
      def delete(conn, params) do
        with {:ok, item} <- #{name}.delete(params["id"]) do
          {:render, %{#{name_file_downcase}: item}}
        end
      end
    end
    """
  end
end
