defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "1.17.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        c: :test,
        coveralls: :test,
        "coveralls.json": :test,
        "coveralls.html": :test,
        t: :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {App.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.0-rc.0", override: true},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.18.3"},
      {:heroicons, "~> 0.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.7.2"},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.3.1", runtime: Mix.env() == :dev},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},

      # github.com/dwyl/auth_plug
      {:auth_plug, "~> 1.5"},
      # github.com/dwyl/useful
      {:useful, "~> 1.15.0", override: true},

      # Track test coverage: github.com/parroty/excoveralls
      {:excoveralls, "~> 0.15", only: [:test, :dev]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      seeds: ["run priv/repo/seeds.exs"],
      setup: ["deps.get", "ecto.reset", "seeds", "tailwind.install"],
      "ecto.setup": [
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop --quiet", "ecto.setup"],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "phx.digest"
      ],
      test: ["ecto.reset", "test"],
      t: ["test"],
      c: ["coveralls.html"],
      s: ["phx.server"]
    ]
  end
end
