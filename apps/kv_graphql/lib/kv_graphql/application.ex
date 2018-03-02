defmodule KVGraphQL.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT")) || raise "missing $PORT"
    # List all child processes to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, KVGraphQL.Router, [], port: port + 100)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KVGraphQL.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
