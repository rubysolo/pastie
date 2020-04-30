defmodule PastieWeb.ReadBody do
  def init(_opts) do
    :ok
  end

  def call(conn, _opts) do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    %{conn | private: Map.put(conn.private, :raw_body, body)}
  end
end
