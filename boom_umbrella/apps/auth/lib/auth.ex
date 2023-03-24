defmodule Auth do
  import Ecto.Query

  def not_found(item) do
    if is_nil(item) do
      {:error, :not_found}
    else
      {:ok, item}
    end
  end

  def not_nil(item, message \\ "param not found") do
    if is_nil(item) do
      {:error, message}
    else
      {:ok, item}
    end
  end

  def generate_numbers(from, to) when is_integer(from) and is_integer(to) do
    to_string(Enum.random(from..to))
  end
end
