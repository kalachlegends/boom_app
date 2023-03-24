defmodule Boom.Smtp.Mail do
  use GenServer
  import Swoosh.Email
  @from_str "boom_hakaton@mail.ru"
  def start_link(state) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  # [email], [login], [uuid], [rundom_number],
  def send(map) do
    GenServer.cast(__MODULE__, {:control_mail, map})
  end

  def send_restore_password(map) do
    GenServer.cast(__MODULE__, {:send_restore_password, map})
  end

  @impl true
  def handle_cast({:control_mail, map}, state) do
    send_mail(map)
    {:noreply, state}
  end

  def handle_cast({:send_restore_password, map}, state) do
    send_restore_password_p(map)
    {:noreply, state}
  end

  defp send_restore_password_p(mail) do
    Task.async(fn ->
      new()
      |> to(mail.email)
      |> subject("Boom Restore Password")
      |> from(@from_str)
      |> html_body("""
      <h1>Hello #{mail.login} </h1>
      <h2>Restore your password!</h2>
      <a
      style="
      padding: 20px;
      background: #232323;
      color: white;
      width: 100%;
      " href=\"#{Boom.Service.Image.generate_url("api/:version/auth/restore_password/#{mail.uuid}/#{mail.number}")}\">evaluation by references for approval</a>
      """)
      |> Boom.Mailer.deliver()
    end)
  end

  defp send_mail(mail) do
    Task.async(fn ->
      new()
      |> to(mail.email)
      |> subject(mail.subject)
      |> from("boom_hakaton@mail.ru")
      |> html_body("""
      <h1>Confirm email </h1>
      <h2>Hello #{mail.login}</h2>
      hello #{mail.login} <a
      style="
      padding: 20px;
      background: #232323;
      color: white;
      width: 100%;
      "
      href=\"#{Boom.Service.Image.generate_url("api/:version/auth/confirm/#{mail.uuid}/#{mail.number}")}\">evaluation by references for approval</a>
      """)
      |> Boom.Mailer.deliver()
    end)
  end
end
