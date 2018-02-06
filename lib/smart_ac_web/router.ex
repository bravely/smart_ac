defmodule SmartAcWeb.Router do
  use SmartAcWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug SmartAcWeb.AirConditionerAuthPipeline
  end

  scope "/", SmartAcWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/admin", AdminController, only: [:index, :update]
  end

  # Other scopes may use custom stacks.
  scope "/api", SmartAcWeb do
    pipe_through :api

    post "/status_report/bulk", StatusReportController, :bulk
  end

  post "/api/air_conditioner", SmartAcWeb.AirConditionerController, :create
end
