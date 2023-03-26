defmodule Boom.Model.MoneyService do
  alias Boom.Model.{MoneyMovement, Organization, Money}

  import Ecto.Query

  def get_mm_by_period(%{start_date: start_date, end_date: end_date}) do
    {start_date, end_date} =
      if is_nil(start_date) or is_nil(end_date) do
        end_date = Date.end_of_month(Date.utc_today())
        start_date = Date.new!(Date.utc_today().year, Date.utc_today().month, 1)
        {start_date, end_date}
      else
        {start_date, end_date}
      end

    from(
      org in Organization,
      join: mm in MoneyMovement,
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

  def get_money_by_org_id(org_id) do
    from(
      org in Organization,
      join: money in Money,
      on: money.org_id == org.id,
      preload: [:money],
      where: org.id == ^org_id,
      select: org
    )
    |> Boom.Repo.one()
    |> case do
      {:error, reason} ->
        {:error, reason}

      nil ->
        {:error, "Не существует данной организации"}

      struct ->
        {:ok, struct}
    end
  end

  def incteract_with_money(mm) do
    money =
      from(
        money in Boom.Model.Money,
        where: money.org_id == ^mm.org_id,
        select: money
      )
      |> Boom.Repo.one()

    new_cash =
      case mm.movement do
        0 ->
          Decimal.add(
            "#{money.cash.bills}.#{money.cash.coins}",
            "-#{mm.cash.bills}.#{mm.cash.coins}"
          )

        1 ->
          Decimal.add(
            "#{money.cash.bills}.#{money.cash.coins}",
            "#{mm.cash.bills}.#{mm.cash.coins}"
          )
      end
      |> decimal_to_money()

    Boom.Model.Money.update(money, %{cash: new_cash})
  end

  def decimal_to_money(d) do
    [bills_str, coins_str] = d |> Decimal.to_string() |> String.split(".")
    %{bills: String.to_integer(bills_str), coins: String.to_integer(coins_str)}
  end
end
