defmodule Mofiin.PageController do
  use Mofiin.Web, :controller

  alias Mofiin.Auth
  alias Mofiin.Auth.User
  alias Mofiin.Auth.Guardian
  alias Mofiin.Media

  def index(conn, _params) do
    banners = Media.list_banners()
    render(conn, "index.html", banners: banners)
  end

  def dashboard(conn, _params) do
    render conn, "dashboard.html"
  end

  @spec get_login(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def get_login(conn, _params) do
    changeset = Auth.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    message = if maybe_user != nil do
      "Welcomeback! Please login."
    else
      "No one is logged in"
    end
    conn
      |> put_flash(:info, message)
      |> render("login.html", changeset: changeset, action: page_path(conn, :login), maybe_user: maybe_user)
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    Auth.authenticate_user(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/admin")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/admin/dashboard")
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: page_path(conn, :login))
  end

  def secret(conn, _params) do
    render(conn, "secret.html")
  end

end
