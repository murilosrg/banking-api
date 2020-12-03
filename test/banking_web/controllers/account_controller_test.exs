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
      conn =
        post(conn, "api/v1/account/sign_in", %{
          "name" => "Jaden Smith",
          "email" => "jaden-test@example.com"
        })

      assert %{"message" => %{"password" => ["can't be blank"]}} = json_response(conn, 400)
    end
  end

  describe "login/2" do
    test "return 200 when user credentials is valid", %{conn: conn} do
      client = insert(:client)

      conn =
        post(conn, "api/v1/login", %{
          "email" => client.email,
          "password" => "123456"
        })

      expected = %{"email" => client.email}
      assert expected = json_response(conn, 200)
    end

    test "return 401 when user credentials is invalid", %{conn: conn} do
      client = insert(:client)

      conn =
        post(conn, "api/v1/login", %{
          "email" => client.email,
          "password" => "1234567"
        })

      assert %{"message" => "Unauthorized"} = json_response(conn, 401)
    end

    test "return 401 when user credentials is valid but is not a client", %{conn: conn} do
      employee = insert(:employee)

      conn =
        post(conn, "api/v1/login", %{
          "email" => employee.id,
          "password" => "123456"
        })

      assert %{"message" => "Unauthorized"} = json_response(conn, 401)
    end
  end
end
