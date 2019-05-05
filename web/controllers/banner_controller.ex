defmodule Mofiin.BannerController do
  use Mofiin.Web, :controller

  alias Mofiin.Media
  alias Mofiin.Media.Banner

  def index(conn, _params) do
    banners = Media.list_banners()
    token = get_csrf_token()
    render(conn, "index.html", banners: banners, token: token)
  end

  def new(conn, _params) do
    changeset = Media.change_banner(%Banner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"banner" => banner_params}) do
    case Media.create_banner(banner_params) do
      {:ok, banner} ->
        conn
        |> put_flash(:info, "Banner created successfully.")
        |> redirect(to: banner_path(conn, :show, banner))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    banner = Media.get_banner!(id)
    render(conn, "show.html", banner: banner)
  end

  def edit(conn, %{"id" => id}) do
    banner = Media.get_banner!(id)
    changeset = Media.change_banner(banner)
    render(conn, "edit.html", banner: banner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "banner" => banner_params}) do
    banner = Media.get_banner!(id)

    case Media.update_banner(banner, banner_params) do
      {:ok, banner} ->
        conn
        |> put_flash(:info, "Banner updated successfully.")
        |> redirect(to: banner_path(conn, :show, banner))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", banner: banner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    banner = Media.get_banner!(id)
    {:ok, _banner} = Media.delete_banner(banner)

    conn
    |> put_flash(:info, "Banner deleted successfully.")
    |> redirect(to: banner_path(conn, :index))
  end
end
