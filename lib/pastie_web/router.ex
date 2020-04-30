defmodule PastieWeb.Router do
  use PastieWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PastieWeb do
    pipe_through :browser

    get "/status", StatusController, :show

    get "/pastes", PasteController, :index
    get "/pastes/:id", PasteController, :show

    delete "/paste/*path", PasteController, :delete
    patch "/paste/*path", PasteController, :patch
    post "/paste/*path", PasteController, :post
    put "/paste/*path", PasteController, :put
  end

  # Other scopes may use custom stacks.
  # scope "/api", PastieWeb do
  #   pipe_through :api
  # end

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
      live_dashboard "/dashboard", metrics: PastieWeb.Telemetry
    end
  end
end
