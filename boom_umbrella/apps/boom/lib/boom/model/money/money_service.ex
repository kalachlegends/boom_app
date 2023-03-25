defmodule Boom.Model.MoneyService do
  alias Boom.Model.{MoneyMovement, Organization}

  import Ecto.Query

  def get_by_period(%{start_date: start_date, end_date: end_date}) do
    {start_date, end_date} =
      if is_nil(start_date) or is_nil(end_date) do
        end_date = Date.end_of_month(Date.utc_today())
        start_date = Date.new!(Date.utc_today().year, Date.utc_today().month, 1)
        {start_date, end_date}
      else
        {start_date, end_date}
      end

    from(
      mm in MoneyMovement,
      join: org in Organization,
      on: mm.org_id == org.id,
      where: fragment("CAST(? as DATE) BETWEEN ? AND ?", mm.inserted_at, ^start_date, ^end_date),
      select: %{
        name: org.title,
        cash: mm.cash,
        type: mm.type,
        movement: mm.movement,
        attrs: mm.attrs
      }
    )
    |> Boom.Repo.all()
    |> case do
      {:error, reason} ->
        {:error, reason}

      [] ->
        {:ok, []}

      list ->
        {:ok, list}
    end
  end
end
