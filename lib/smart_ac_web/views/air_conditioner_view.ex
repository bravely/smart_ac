defmodule SmartAcWeb.AirConditionerView do
  use SmartAcWeb, :view

  def render("create.json", %{air_conditioner_token: token}) do
    %{token: token}
  end

  def render("error.json", %{changeset: changeset}) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
