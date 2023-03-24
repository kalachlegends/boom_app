defmodule Manuscript.Generator.Vue do
  alias Manuscript.Generator.Vue.Template

  def generate() do
    Manuscript.Generator.get_route_modules()
    |> Enum.map(fn x ->
      title_name = x |> get_title()

      title = title_name |> String.replace(~r/(\s|-|>|\/)/, "_")

      path = File.cwd!() <> "/generate_frotend/" <> title <> ""
      File.mkdir(path)

      Enum.map(["post", "get", "patch"], fn x ->
        File.mkdir("#{path}/#{x}")
      end)

      Enum.map(x.functions, fn func ->
        title_name = func |> get_title()
        title = title_name |> String.replace(~r/(\s|-|>|\/)/, "_")
        route = func.route |> replace_route
        method = func.method

        cond do
          method == "post" ->
            template = Template.template_for_send(title_name, func.doc_params, route, method)

            File.write(path <> "/post/#{title}.vue", template)

          method == "patch" ->
            template = Template.template_for_send(title_name, func.doc_params, route, method)

            File.write(path <> "/patch/#{title}.vue", template)

          method == "patch" ->
            template = Template.template_for_send(title_name, func.doc_params, route, method)

            File.write(path <> "/put/#{title}.vue", template)

          method == "get" ->
            # template = Template.template_for_get(title_name, func.doc_params, route)
            nil

          # File.write(path <> "/get/#{title}.vue", template)

          true ->
            nil
        end
      end)
    end)
  end

  defp get_title(x) do
    x[:title] || x[:module] |> Manuscript.Generator.module_to_string()
  end

  defp replace_route(string) do
    String.replace(string, ~r/\/api\/:version\//, "/")
  end
end
