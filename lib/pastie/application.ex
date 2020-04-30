defmodule Pastie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Pastie.Repo,
      # Start the Telemetry supervisor
      PastieWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pastie.PubSub},
      # Start the Endpoint (http/https)
      PastieWeb.Endpoint
      # Start a worker by calling: Pastie.Worker.start_link(arg)
      # {Pastie.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pastie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PastieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
