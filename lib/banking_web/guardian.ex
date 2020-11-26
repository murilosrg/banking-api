defmodule BankingWeb.Guardian do
  @moduledoc """
  JWT Handler
  """
  use Guardian, otp_app: :banking

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.email)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    email = claims["sub"]
    resource = Banking.UserRepo.get_user!(email)
    {:ok, resource}
  end
end
