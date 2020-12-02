defmodule Banking.FindAccount do
  @moduledoc """
  Find a account
  """

  import Ecto.Query
  alias Banking.{Account, Repo, User}

  def run(email) do
    Account
    |> join(:left, [a], u in User, on: a.user_id == u.id)
    |> where([a, u], u.email == ^email)
    |> Repo.one!()
  end
end
