defmodule Mofiin.Router do
  use Mofiin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Mofiin.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", Mofiin do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

  end

  pipeline :admin_layout do
    plug :put_layout, {Mofiin.LayoutView, :admin}
  end

  scope "/admin", Mofiin do
    pipe_through [:browser, :auth]

    get "/", PageController, :get_login
    post "/", PageController, :login
  end

  scope "/admin", Mofiin do
    pipe_through [:browser, :auth, :ensure_auth, :admin_layout]

    get "/logout", PageController, :logout

    get "/banners/:id/delete", BannerController, :delete
    resources "/banners", BannerController
    get "/dashboard", PageController, :dashboard
    get "/secret", PageController, :secret
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mofiin do
  #   pipe_through :api
  # end
end
