defmodule BankingWeb.Backoffice.ReportView do
  use BankingWeb, :view

  def render("report.json", %{report: total}) do
    %{total: total || 0}
  end
end
