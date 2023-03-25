defmodule Boom.Location do
  alias Boom.Model.Location

  def load_locations() do
    with {:ok, locations} <- File.read("locations/s_ats.txt"),
         locations <- String.split(locations, "\n", trim: true) |> List.delete_at(0),
         {:ok, types} <- File.read("locations/d_ats_types.txt"),
         types <- String.split(types, "\n", trim: true) |> List.delete_at(0) do
      types =
        Enum.map(types, fn text ->
          [id | [_ | [_ | [_ | [type_kz | [type | _]]]]]] = String.split(text, "|")
          {id, %{type: type}}
        end)
        |> Map.new()

      locations =
        Enum.map(locations, fn text ->
          [id | [parent_id | [type_id | [_ | [cato | [name_kz | [name | _]]]]]]] =
            String.split(text, "|")

          parent_id = if parent_id == "", do: nil, else: String.to_integer(parent_id)
          type = Map.get(types, type_id, %{type: "Bad type", type_kz: "Bad type"})

          {id,
           Map.merge(
             %{
               id: String.to_integer(id),
               parent_id: parent_id,
               name: name
             },
             type
           )}
        end)
        |> Map.new()

      Enum.map(locations, fn {_, location} ->
        {kz, ru} =
          Enum.reduce_while(1..100, {"", "", location.id, location.parent_id}, fn
            _, {kz, ru, id, next_id} when is_nil(next_id) ->
              loc = Map.get(locations, to_string(id))

              {:halt,
               {" ",
                String.trim(Enum.join([loc.type, loc.name, ru], " "))}}

            _, {kz, ru, id, next_id} ->
              loc = Map.get(locations, to_string(id))

              {:cont,
               {" ",
                Enum.join([loc.type, loc.name, ru], " "),
                Map.get(locations, to_string(next_id)).id,
                Map.get(locations, to_string(next_id)).parent_id}}
          end)

        Map.merge(location, %{full_name: ru})
      end)
      |> IO.inspect()
      |> Enum.each(&Location.add(&1))
    end
  end
end
