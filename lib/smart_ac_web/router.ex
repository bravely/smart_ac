defmodule SmartAcWeb.Router do
  use SmartAcWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SmartAcWeb.UserAuthPipeline
    plug SmartAcWeb.Plug.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug SmartAcWeb.AirConditionerAuthPipeline
  end

  pipeline :browser_authenticated do
    plug Guardian.Plug.EnsureAuthenticated, module: SmartAcWeb.Guardian,
      error_handler: SmartAcWeb.UserAuthErrorHandler
  end

  scope "/", SmartAcWeb do
    pipe_through :browser # Use the default browser stack

    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true
    scope "/admin" do
      get "/password_reset/new", AdminController, :new_password_reset
      post "/password_reset", AdminController, :password_reset

      get "/edit_password", AdminController, :edit_password
      put "/update_password", AdminController, :update_password
    end

    pipe_through :browser_authenticated

    get "/", PageController, :index
    resources "/admin", AdminController, only: [:index, :new, :create, :update]
    scope "/air_conditioner" do
      get "/search", AirConditionerController, :search
      post "/:id/resolve", AirConditionerController, :resolve
      resources "/", AirConditionerController, only: [:index, :show]
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", SmartAcWeb do
    pipe_through :api

    post "/status_report/bulk", StatusReportController, :bulk
  end

  post "/api/air_conditioner", SmartAcWeb.AirConditionerController, :create
end
