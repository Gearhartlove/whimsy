defmodule WhimsyWeb.Router do
  use WhimsyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WhimsyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WhimsyWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/app", WhimsyWeb do
    pipe_through :browser

    get "/", AppController, :index
    post "/generate_encounter", AppController, :generate_encounter
  end

  # HTMX routes - return HTML fragments
  scope "/htmx", WhimsyWeb do
    pipe_through :browser

    get "/greeting", HtmxController, :greeting
    get "/roll", HtmxController, :roll_dice
  end

  # Other scopes may use custom stacks.
  # scope "/api", WhimsyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:whimsy, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WhimsyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
