defmodule PastieWeb.PasteController do
  use PastieWeb, :controller

  alias Pastie.{Paste,Repo}

  def index(conn, _params) do
    pastes = Repo.index()
    render(conn, "index.html", pastes: pastes)
  end

  def show(conn, %{"id" => id}) do
    paste = Repo.get(id)
    render(conn, "show.html", paste: paste)
  end

  def delete(conn, _params) do
    handle(conn)
  end

  def patch(conn, _params) do
    handle(conn)
  end

  def post(conn, _params) do
    handle(conn)
  end

  def put(conn, _params) do
    handle(conn)
  end

  defp handle(conn) do
    Repo.store(%Paste{
      id: List.first(get_req_header(conn, "x-request-id")) || List.first(get_resp_header(conn, "x-request-id")) || gen_id(),
      ts: DateTime.utc_now(),
      path: String.replace_leading(conn.request_path, "/paste", ""),
      body: conn.private.raw_body,
      method: conn.method,
    })

    send_resp(conn, :ok, "")
  end

  defp gen_id do
    binary = <<
      System.system_time(:nanosecond)::64,
      :erlang.phash2({node(), self()}, 16_777_216)::24,
      :erlang.unique_integer()::32
    >>

    Base.url_encode64(binary)
  end
end
