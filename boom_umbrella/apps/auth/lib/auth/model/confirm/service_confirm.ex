defmodule Auth.Service.Confirm do
  alias Auth.Model.Confirm
  alias Auth.Model.User
  import Ecto.Query

  def confirm_user(params) do
    with {:ok, item} <-
           Confirm.get(%{id: params["id"], number: params["number"]}),
         {:ok, user} <-
           User.get(%{id: item.user_id}),
         {:ok, _} <-
           Auth.Model.User.changeset_update_is_registred(user, %{is_registred: true}),
         {:ok, _} <- Confirm.delete(item.id) do
      :ok
    end
  end

  def request_restore_password(_conn, params) do
    with {:ok, item} <-
           User.get_by(params["email"], :email) do
      if Confirm.get_all(user_id: item.id) do
        {:ok, item_confirm} = Confirm.add(user_id: item.id)
        {:render, %{status: "ok"}}
      end

      {:render, %{status: "ok"}}
    end
  end

  def remove_users_without_registed() do
    date = Timex.now()
    date = Timex.shift(date, minutes: 20)

    from(user in User,
      where: user.is_registred == false and user.inserted_at <= ^date,
      join: confirm in Confirm,
      on: confirm.user_id == user.id,
      select: %{
        confirm_id: confirm.id,
        user_id: user.id
      }
    )
    |> Auth.Repo.delete_all()
  end

  def restore_password(params) do
    with {:ok, confirm_item} <-
           Confirm.get(%{id: params["confirm_id"], confirmed: true, number: params["number"]}),
         {:ok, user} <- User.get(id: IO.inspect(confirm_item.user_id)),
         {:ok, _item} <- Confirm.delete(%{id: confirm_item.id}),
         {:ok, user} <-
           User.restore_password(user, %{
             password: params["password"]
           }),
         token <- Auth.Token.generate_and_sign!(%{"user_id" => user.id}) do
      {:ok, %{user: user, token: token}}
    end
  end
end
