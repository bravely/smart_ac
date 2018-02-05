defmodule SmartAcWeb.AirConditionerAuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :smart_ac

  plug Guardian.Plug.VerifyHeader, key: :authorization
  plug Guardian.Plug.EnsureAuthenticated, key: :authorization
  plug Guardian.Plug.LoadResource, key: :authorization
end
