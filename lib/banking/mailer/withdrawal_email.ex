defmodule Banking.WithdrawalEmail do
  @moduledoc """
  Send withdrawal email
  """
  import Bamboo.Email

  def create(to, amount) do
    new_email()
    |> to(to)
    |> from("baking@email.com")
    |> subject("Saque realizado com sucesso")
    |> html_body(
      "<strong>Parabéns, o saque no valor de R$ #{amount} foi realizado com sucesso!</strong>"
    )
  end
end
