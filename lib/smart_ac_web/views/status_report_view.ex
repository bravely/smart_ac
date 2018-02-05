defmodule SmartAcWeb.StatusReportView do
  use SmartAcWeb, :view

  def render("bulk.json", %{number_created: number_created}) do
    %{number_created: number_created}
  end

  def render("error.json", %{reason: reason}) do
    %{message: reason}
  end
end
