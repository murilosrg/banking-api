defmodule BankingWeb.Backoffice.AccountControllerTest do
  use BankingWeb.ConnCase, async: true

  import Banking.Factory

  describe "create/2" do
    test "return 200 when params is valid", %{conn: conn} do
      conn =
        post(conn, "api/v1/account/sign_in", %{
          "name" => "Jaden Smith",
          "email" => "jaden-test@example.com",
          "password" => "123456"
        })

      expected = %{"email" => "jaden-test@example.com"}
      assert expected = json_response(conn, 201)
    end

    test "return 400 when params is invalid", %{conn: conn} do
      employee = insert(:employee)

      conn =
        post(conn, "api/v1/account/sign_in", %{
          "name" => "Jaden Smith",
          "email" => "jaden-test@example.com"
        })

      assert %{"message" => %{"password" => ["can't be blank"]}} = json_response(conn, 400)
    end
  end
end
