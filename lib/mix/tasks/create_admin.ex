defmodule Mix.Tasks.SmartAc.CreateAdmin do
  @moduledoc """
  Creates an admin user.
  """
  use Mix.Task

  alias SmartAc.Accounts

  @shortdoc "Creates an admin with a given email and password"
  def run([email, password]) do
    Mix.Task.run("app.start", [])

    {:ok, user} = Accounts.create_user(%{email: email, password: password})

    IO.puts "#{user.email} created!"
  end
end
