defmodule BankingWeb.Router do
  use BankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt do
    plug BankingWeb.Pipeline
  end

  pipeline :backoffice_jwt do
    plug BankingWeb.BackofficePipeline
  end

  scope "/api/v1", BankingWeb do
    pipe_through :api

    post("/backoffice/login", Backoffice.AuthController, :create)
    post("/login", AccountController, :login)
    post("/account/sign_in", AccountController, :create)
  end

  scope "/api/v1", BankingWeb do
    pipe_through [:api, :jwt]

    post("/transaction/withdrawal", TransactionController, :withdrawal)
    post("/transaction/transfer", TransactionController, :transfer)
  end

  scope "/api/v1", BankingWeb do
    pipe_through [:api, :backoffice_jwt]

    get("/backoffice/report", Backoffice.ReportController, :report)
  end
end
