defmodule AuthTest do
  use ExUnit.Case

  test "register_user" do
    assert {:error, errors} = Auth.Service.User.register("email", "1234", "1234", "login", %{})

    assert {:error, _} =
             Auth.Service.User.register("ema123asasil@", "1234", "1234", "1243", %{
               "name" => "123456",
               "img" => ""
             })

    assert {:ok, _} = Auth.Service.User.register("email@asd", "1234", "1234", "login", %{})
  end
end
