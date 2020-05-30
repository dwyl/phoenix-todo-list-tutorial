defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", AppWeb do
    pipe_through :browser

    # see: https://github.com/dwyl/ping
    get "/ping", PingController, :ping

    get "/", ItemController, :index
    resources "/items", ItemController
    get "/items/toggle/:id", ItemController, :toggle
    get "/clear", ItemController, :clear_completed
    # this route will "catch all" so has to be last:
    get "/:filter", ItemController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
    end
  end
end
