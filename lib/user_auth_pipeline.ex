defmodule SmartAcWeb.UserAuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :smart_ac

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
end
