defmodule Formflow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FormflowWeb.Telemetry,
      Formflow.Repo,
      {DNSCluster, query: Application.get_env(:formflow, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Formflow.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Formflow.Finch},
      # Start a worker by calling: Formflow.Worker.start_link(arg)
      # {Formflow.Worker, arg},
      # Start to serve requests, typically the last entry
      FormflowWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Formflow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FormflowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
