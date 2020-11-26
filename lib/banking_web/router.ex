defmodule BankingWeb.Router do
  use BankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BankingWeb do
    pipe_through :api

    post("/backoffice/sign_in", Backoffice.AuthController, :create)
  end
end
