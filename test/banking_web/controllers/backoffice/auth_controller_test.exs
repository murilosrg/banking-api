defmodule BankingWeb.Backoffice.AuthControllerTest do
  use BankingWeb.ConnCase, async: true

  import Banking.Factory

  describe "create/2" do
    test "return 200 when user credentials is valid", %{conn: conn} do
      employee = insert(:employee)

      conn =
        post(conn, "api/v1/backoffice/login", %{
          "email" => employee.email,
          "password" => "123456"
        })

      expected = %{"email" => employee.email}
      assert expected = json_response(conn, 200)
    end

    test "return 401 when user credentials is invalid", %{conn: conn} do
      employee = insert(:employee)

      conn =
        post(conn, "api/v1/backoffice/login", %{
          "email" => employee.email,
          "password" => "1234567"
        })

      assert %{"message" => "Unauthorized"} = json_response(conn, 401)
    end

    test "return 401 when user credentials is valid but is not a employee", %{conn: conn} do
      client = insert(:client)

      conn =
        post(conn, "api/v1/backoffice/login", %{
          "email" => client.id,
          "password" => "123456"
        })

      assert %{"message" => "Unauthorized"} = json_response(conn, 401)
    end
  end
end
