defmodule Manuscript.Generator do
  alias Postgrex.Extensions.JSON
  @cwd File.cwd!()

  def generate_data() do
    mode = Application.get_env(Manuscript, :mode) || :all
    route_namespace = Application.get_env(Manuscript, :routes)
    app = Application.get_env(Manuscript, :app)
    namespace = Application.get_env(app, :namespace)

    data_map = %{
      application: app,
      namespace: String.replace("#{namespace}", "Elixir.", ""),
      route_namespace: String.replace("#{route_namespace}", "Elixir.", ""),
      mode: mode,
      functions: [],
      routes: []
    }

    cond do
      mode == :only_routes and not is_nil(route_namespace) ->
        %{data_map | routes: get_route_modules() |> delete_tags()}

      mode == :only_functions ->
        %{data_map | functions: get_function_modules() |> delete_tags()}

      true ->
        %{
          data_map
          | functions: get_function_modules() |> delete_tags(),
            routes: get_route_modules() |> delete_tags()
        }
    end
  end

  def get_title_module do
    mode = Application.get_env(Manuscript, :mode) || :all
    route_namespace = Application.get_env(Manuscript, :routes)
    app = Application.get_env(Manuscript, :app)
    namespace = Application.get_env(app, :namespace)

    cond do
      mode == :only_routes and not is_nil(route_namespace) ->
        route_namespace |> module_to_string |> Macro.camelize()

      mode == :only_functions ->
        app |> module_to_string |> Macro.camelize()

      true ->
        app |> Atom.to_string() |> Macro.camelize()
    end
  end

  def get_function_modules(body \\ :no_body) do
    Application.get_env(Manuscript, :app)
    |> :application.get_key(:modules)
    |> case do
      :undefined ->
        []

      {:ok, list} ->
        list
        |> Enum.sort()
        |> Enum.uniq()
        |> Enum.filter(fn i -> not Regex.match?(~r/Manuscript/, "#{i}") end)
        |> Enum.map(fn module_name ->
          {_, _, _, _, doc, doc_params, functions} = Code.fetch_docs(module_name)

          functions_list =
            functions
            |> Enum.filter(fn {{_, _, _}, _, _, type, _} -> type != :hidden end)
            |> Enum.map(fn {{_, function_name, _}, _, _, doc, doc_params} ->
              %{
                name: function_name,
                title: documentation_handler(doc) |> title(),
                documentation: documentation_handler(doc) |> documentation_body(),
                doc_params: doc_params
              }
            end)

          %{
            module: module_name,
            doc_params: doc_params,
            title: documentation_handler(doc) |> title(),
            documentation: documentation_handler(doc) |> documentation_body(),
            functions: functions_list
          }
        end)
    end
  end

  def get_route_modules() do
    Application.get_env(Manuscript, :routes)
    |> case do
      nil ->
        []

      module_name ->
        routes_list =
          apply(module_name, :__routes__, [])
          |> Enum.filter(fn i -> not Regex.match?(~r/Manuscript/, "#{i.plug}") end)

        routes_modules = Enum.map(routes_list, & &1.plug)

        get_function_modules()
        |> Enum.filter(&(&1.module in routes_modules))
        |> Enum.sort()
        |> Enum.map(fn %{module: module_name} = item ->
          functions_list =
            Enum.map(item.functions, fn func_map ->
              Enum.find(routes_list, fn i ->
                i.plug == module_name and i.plug_opts == func_map.name
              end)
              |> case do
                nil -> Map.merge(func_map, %{route: nil, method: nil})
                route -> Map.merge(func_map, %{route: route.path, method: "#{route.verb}"})
              end
            end)
            |> Enum.map(fn %{documentation: documentation, doc_params: doc_params} = item ->
              Map.put(item, :documentation, parse_doc_for_api(documentation, doc_params))
            end)
            |> Enum.filter(&(not is_nil(&1.route)))

          Map.put(item, :functions, functions_list)
        end)
    end
  end

  def parse_doc_for_api(doc, doc_params) when is_binary(doc) do
    cond do
      is_map(doc_params[:body]) ->
        ("## Accepts JSON: \n\r ``` \n\r#{Jason.encode!(doc_params[:body], pretty: true)} \n ``` \n" <>
           doc)
        |> parse_doc_for_api(doc_params |> Map.delete(:body))

      is_map(doc_params[:params]) ->
        ("## Accept params: \n\r```\n\r#{Jason.encode!(doc_params[:params], pretty: true)}\n ``` \n" <>
           doc)
        |> parse_doc_for_api(doc_params |> Map.delete(:params))

      is_binary(doc_params[:auth]) ->
        ("## Accept auth: #{doc_params[:auth]} \n" <> doc)
        |> parse_doc_for_api(doc_params |> Map.delete(:auth))

      true ->
        doc
    end
  end

  def parse_doc_for_api(doc, doc_params) when is_list(doc) do
    Enum.join(doc)
    |> parse_doc_for_api(doc_params)
  end

  def parse_doc_for_api(doc, doc_params) when is_nil(doc) do
    parse_doc_for_api("", doc_params)
  end

  defp title(nil), do: nil

  defp title(str) when is_bitstring(str) do
    case Regex.run(~r/^# (.+?)\n/, str) do
      [_, title] -> title
      _any -> nil
    end
  end

  defp title(_any), do: nil

  defp documentation_body(nil), do: nil

  defp documentation_body(doc) do
    case Regex.run(~r/^# (.+?)\n/, doc) do
      [_, title] -> String.replace(doc, "# #{title}", "")
      _any -> String.split(doc, "\n")
    end
  end

  defp documentation_handler(%{"en" => doc}), do: doc
  defp documentation_handler(:none), do: nil
  defp documentation_handler(_any), do: nil

  def module_to_string(module) when is_atom(module),
    do: module |> to_string() |> String.replace("Elixir.", "")

  def get_readme() do
    with {:ok, file} <-
           File.read(get_path_readme()) do
      file
    else
      {:error, _error} ->
        "Not Found file"
    end
  end

  defp get_path_readme do
    @cwd <> "/" <> "README.md" || Application.get_env(Manuscript, :path_readme)
  end

  def delete_tags(list) do
    Enum.map(list, fn module ->
      if !is_nil(module.functions) do
        functions =
          module.functions
          |> Enum.map(fn x ->
            if !is_nil(x.documentation) do
              documentation =
                if is_list(x.documentation) do
                  check_string(x.documentation)
                else
                  x.documentation
                end

              documentation = String.replace(documentation, ~r/@body/, "")

              Map.put(x, :documentation, documentation)
            else
              x
            end
          end)

        Map.put(module, :functions, functions)
      else
        module
      end
    end)
  end

  defp check_string(item) when is_list(item) do
    Enum.join(item)
  end

  defp check_string(item), do: item
end
