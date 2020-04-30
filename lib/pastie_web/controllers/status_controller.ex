defmodule PastieWeb.StatusController do
  use PastieWeb, :controller

  def show(conn, _params) do
    text conn, "ok"
  end
end
