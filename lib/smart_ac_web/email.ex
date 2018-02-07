defmodule SmartAcWeb.Email do
  use Bamboo.Phoenix, view: SmartAcWeb.EmailView

  def password_reset(user) do
    new_email(
      to: user.email,
      subject: "SmartAC: Reset Password",
      from: "noreply@#{host()}"
    )
    |> assign(:user, user)
    |> render("password_reset.text")
  end

  defp host, do: Application.get_env(:smart_ac, SmartAcWeb.Endpoint)[:url][:host]
end
