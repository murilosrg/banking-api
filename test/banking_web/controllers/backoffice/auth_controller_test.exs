defmodule BankingWeb.Backoffice.AuthControllerTest do
  use BankingWeb.ConnCase, async: true

  import Banking.Factory

  describe "create/2" do
    setup %{conn: conn} do
      insert(:employee)
      insert(:client)

      %{con: conn}
    end

    test "return 200 when user credentials is valid", %{conn: conn} do
      conn =
        post(conn, "api/v1/backoffice/sign_in", %{
          "email" => "employee@example.com",
          "password" => "123456"
        })

      assert %{"email" => "employee@example.com"} = json_response(conn, 200)
    end

    test "return 401 when user credentials is invalid", %{conn: conn} do
      conn =
        post(conn, "api/v1/backoffice/sign_in", %{
          "email" => "employee@example.com",
          "password" => "1234567"
        })

      assert %{"error" => "Unauthorized"} = json_response(conn, 401)
    end

    test "return 401 when user credentials is valid but is not a employee", %{conn: conn} do
      conn =
        post(conn, "api/v1/backoffice/sign_in", %{
          "email" => "client@example.com",
          "password" => "123456"
        })

      assert %{"error" => "Unauthorized"} = json_response(conn, 401)
    end
  end
end
