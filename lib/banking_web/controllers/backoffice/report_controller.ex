defmodule BankingWeb.Backoffice.ReportController do
  use BankingWeb, :controller

  alias Banking.ReportTransaction
  alias BankingWeb.Guardian

  action_fallback BankingWeb.FallbackController

  def report(conn, params) do
    Guardian.Plug.current_resource(conn)

    with {:ok, report} <- ReportTransaction.run(params) do
      render(conn, "report.json", report: report)
    end
  end
end
