defmodule Banking.ReportTransaction do
  @moduledoc """
  Creating a transfer transaction
  """

  use Ecto.Schema
  import Ecto.{Changeset, Query}

  alias Banking.{Transaction, TransactionQuery, Repo}

  def run(params) do
    build(params)
    |> case do
      %Ecto.Changeset{valid?: true, changes: changes} ->
        total =
          Transaction
          |> filter_period(changes)
          |> Repo.aggregate(:sum, :amount)

        {:ok, total}

      changeset ->
        {:error, changeset}
    end
  end

  defp build(params) do
    %TransactionQuery{}
    |> cast(params, [:filter, :value])
    |> validate_required([:filter])
    |> validate_inclusion(:filter, filter_types(),
      message: "Valid period types: day, month, year or total"
    )
  end

  defp filter_types do
    ["day", "month", "year", "total"]
  end

  defp filter_period(query, %{filter: filter, value: value}),
    do: filter_period(query, String.to_atom(filter), value)

  defp filter_period(query, _), do: query

  defp filter_period(query, :day, date) do
    {:ok, converted} = Date.from_iso8601(date)

    from t in query,
      where:
        fragment(
          "cast(inserted_at as date) = ?",
          ^converted
        )
  end

  defp filter_period(query, :month, date) do
    [yyyy, mm] = String.split(date, "-")

    from t in query,
      where:
        fragment(
          "extract(month from inserted_at) = ? and extract(YEAR from inserted_at) = ?",
          ^String.to_integer(mm),
          ^String.to_integer(yyyy)
        )
  end

  defp filter_period(query, :year, year) do
    from t in query,
      where:
        fragment(
          "extract(YEAR from inserted_at) = ?",
          ^String.to_integer(year)
        )
  end

  defp filter_period(query, _, _), do: query
end
