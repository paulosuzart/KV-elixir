defmodule KVGraphql.MixProject do
  use Mix.Project

  def project do
    [
      app: :kv_graphql,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {KVGraphQL.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [ {:kv_server, in_umbrella: true},
      {:absinthe, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},
      {:poison, "~> 2.1.0"},
      {:cowboy, "~> 1.1.2"},
      {:plug, "~> 1.3.4"}
    ]
  end
end
