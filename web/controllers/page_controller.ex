defmodule Mofiin.PageController do
  use Mofiin.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
