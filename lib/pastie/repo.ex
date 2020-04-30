defmodule Pastie.Repo do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.merge([name: __MODULE__], opts))
  end

  def init(:ok) do
    {:ok, []}
  end

  def index do
    GenServer.call(__MODULE__, :index)
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def store(paste) do
    GenServer.call(__MODULE__, {:store, paste})
  end

  def handle_call(:index, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:get, id}, _from, state) do
    paste = Enum.find(state, & &1.id == id)
    {:reply, paste, state}
  end

  def handle_call({:store, request}, _from, state) do
    {:reply, :ok, [request | state]}
  end
end
