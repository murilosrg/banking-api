defmodule BankingWeb.BackofficePipeline do
  @moduledoc """
  A pipeline to guardian
  """

  use Guardian.Plug.Pipeline,
    otp_app: :banking,
    module: BankingWeb.Guardian,
    error_handler: BankingWeb.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer", claims: %{employee: true}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
