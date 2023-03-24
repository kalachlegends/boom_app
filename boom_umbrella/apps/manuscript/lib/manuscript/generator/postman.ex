defmodule Manuscript.Postman do
  @default_host_list ["{{host}}"]
  @default_postman_id "UASdDSAgDF"

  @default_exporter_schema "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  @defaults_export_id "UASdDSAgDFDASqweE"

  defp get_config_variable(:auth_tokens),
    do:
      Application.get_env(Manuscript, :auth_tokens) ||
        [
          %{
            key: "token",
            value: "write token",
            type: "string"
          }
        ]

  defp get_config_variable(:default_variable),
    do:
      Application.get_env(Manuscript, :default_variable) ||
        [
          %{
            key: "host",
            value: "http://localhost:5000/",
            type: "string"
          }
        ]

  defp get_config_variable(:default_name_info),
    do:
      Application.get_env(Manuscript, :name_collection) ||
        Application.get_env(Manuscript, :app)
        |> Atom.to_string()
        |> String.upcase()

  defp get_config_variable(:file_path) do
    file_path = Application.get_env(Manuscript, :file_path_collection)

    if !is_nil(file_path) do
      file_path
    else
      case :os.type() do
        {:win32, _} ->
          "/temp/collection.#{get_config_variable(:default_name_info)}.json"

        _x ->
          "/tmp/collection.#{get_config_variable(:default_name_info)}.json"
      end
    end
  end

  def generate do
    items_collection =
      Manuscript.Generator.get_route_modules()
      |> Enum.map(fn x_route ->
        items = generate_items(x_route)

        if !is_nil(x_route[:title]) do
          generate_default_map(:item_collection,
            name: x_route[:title],
            item: items,
            description: x_route[:documentation]
          )
        else
          generate_default_map(:item_collection,
            name: x_route[:module] |> Manuscript.Generator.module_to_string(),
            item: items,
            description: x_route[:documentation]
          )
        end
      end)

    with {:ok, string_jason} <-
           Jason.encode(
             %{
               info: generate_default_map(:info),
               item: items_collection,
               variable:
                 get_config_variable(:default_variable) ++ get_config_variable(:auth_tokens)
             },
             pretty: true
           ),
         :ok <-
           File.write(get_config_variable(:file_path), string_jason) do
      {:ok, get_config_variable(:file_path)}
    end
  end

  def generate_default_map(:info, attrs \\ []) do
    %{
      _postman_id: attrs[:postman_id] || @default_postman_id,
      name: attrs[:name] || get_config_variable(:default_name_info),
      schema: attrs[:schema] || @default_exporter_schema,
      _exporter_id: attrs[:exporter_id] || @defaults_export_id
    }
  end

  def generate_body(doc_params, attrs \\ []) do
    if !is_nil(doc_params[:body]) do
      %{
        mode: attrs[:mode] || "raw",
        raw: doc_params[:body] |> Jason.encode!(pretty: true),
        options: %{
          raw: %{
            language: attrs[:language] || "json"
          }
        }
      }
    end
  end

  def generate_items(item_list) do

    if !is_nil(item_list[:functions]) do
      Enum.map(item_list[:functions], fn x ->
        cond do
          is_nil(x[:title]) ->
            generate_default_map(:item,
              name: x[:name],
              method: x[:method],
              description: x[:documentation] |> check_string(),
              url_raw: (hd(@default_host_list) <> x[:route]) |> String.replace(":", ""),
              host: @default_host_list,
              body: x[:doc_params] |> generate_body(),
              path: generate_path(x[:route]),
              auth: x[:doc_params] |> generate_auth(),
              query: x[:doc_params] |> generate_params(),
              event: x[:doc_params] |> generate_test |> generate_auth_pre_request(x[:doc_params])
            )

          true ->
            generate_default_map(:item,
              name: x[:title],
              method: x[:method],
              description: x[:documentation] |> check_string(),
              body: x[:doc_params] |> generate_body(),
              url_raw: (hd(@default_host_list) <> x[:route]) |> String.replace(":", ""),
              host: @default_host_list,
              path: generate_path(x[:route]),
              auth: x[:doc_params] |> generate_auth(),
              query: x[:doc_params] |> generate_params(),
              event: x[:doc_params] |> generate_test |> generate_auth_pre_request(x[:doc_params])
            )
        end
      end)
    else
      []
    end
  end

  def generate_default_map(:item_collection, attrs) do
    %{
      name: attrs[:name],
      item: attrs[:item],
      description: attrs[:description] || ""
    }
  end

  def generate_default_map(:item, attrs) do
    %{
      name: attrs[:name],
      event: attrs[:event],
      request: %{
        method: attrs[:method],
        auth: attrs[:auth] || %{},
        header: attrs[:header] || [],
        body: attrs[:body],
        url: %{
          raw: attrs[:url_raw],
          host: attrs[:host_list] || @default_host_list,
          path: attrs[:path] || [],
          query: attrs[:query] || []
        },
        description: attrs[:description] || ""
      },
      response: attrs[:response] || []
    }
  end

  def generate_test(doc_params) do
    if !is_nil(doc_params[:test]) and is_bitstring(doc_params[:test]) do
      [
        %{
          listen: "test",
          script: %{
            exec: [
              "pm.test(\"Status code is #{doc_params[:test]}\", function () {\r",
              "    pm.response.to.have.status(#{doc_params[:test]});\r",
              "});\r"
            ],
            type: "text/javascript"
          }
        }
      ]
    end
  end

  def generate_auth_pre_request(test, doc_params) do
    is_enable = doc_params[:auth_pre_request][:is_enabled] || false

    if is_nil(test) and is_enable do
      token = doc_params[:auth_pre_request][:token] || "token"

      object_str = doc_params[:auth_pre_request][:object_token] || "token"

      [
        %{
          listen: "test",
          script: %{
            exec: [
              "pm.test(\"Get token\", function () {\n",
              "    var jsonData = pm.response.json();",
              "    let bearerToken = jsonData.#{object_str};",
              "    pm.collectionVariables.set(\"#{token}\", bearerToken);",
              "});"
            ],
            type: "text/javascript"
          }
        }
      ]
    end
  end

  def generate_params(doc_params) do
    if is_map(doc_params[:params]) do
      doc_params[:params]
      |> Enum.map(fn {key, value} ->
        if is_map(value) do
          %{
            key: key,
            value: value[:value],
            description: value[:description]
          }
        else
          %{
            key: key,
            value: value
          }
        end
      end)
    end
  end

  def generate_auth(doc_params, type_token \\ :bearer) do
    if check_tokens(doc_params[:auth]) do
      %{
        type: type_token |> Atom.to_string()
      }
      |> Map.put(type_token, [
        %{
          key: "token",
          value: "{{" <> doc_params[:auth] <> "}}",
          type: "string"
        }
      ])
    end
  end

  defp generate_path(item) do
    Regex.scan(~r/(\/|:)\w+/, item)
    |> Enum.map(fn x -> hd(x) |> String.replace(~r/(\/)/, "") end)
  end

  defp check_tokens(token) do
    Enum.any?(get_config_variable(:auth_tokens), fn x -> token == x.key end)
  end

  defp check_string(item) when is_list(item) do
    Enum.join(item)
  end

  defp check_string(item), do: item

  def delete_r_n_int_string(string) do
    string
    |> String.replace(~r/(\r|\n)/, "")
  end
end
