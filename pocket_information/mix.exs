defmodule PocketInformation.MixProject do
  use Mix.Project

  @integration_toolkit_version "0.0.9.6"
  @integration_toolkit_repo "https://GrupoBancolombia@dev.azure.com/GrupoBancolombia/Vicepresidencia%20Servicios%20de%20Tecnolog%C3%ADa/_git/NU0195001_INTEGRATION_TOOLKIT_EX"

  def project do
    [
      app: :pocket_information,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.xml": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :jason, :castore],
      mod: {PocketInformation.Application, []}
    ]
  end

  def rules(_) do
    [
      name: ~w[required string uppercase]a
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:timex, "~> 3.0"},
      {:distillery, "~> 2.1"},
      {:excoveralls, "~> 0.10", only: :test},
      {:credo_sonarqube, "~> 0.1.3", only: [:dev, :test]},
      {:credo, "~> 1.6.2", only: [:dev, :test], override: true},
      {:sobelow, "~> 0.11.1", only: :dev},
      {:ex_unit_sonarqube, "~> 0.1", only: :test},
      {:ex_doc, "~> 0.28.3", only: :dev, runtime: false},
      {:request_validator, "~> 0.6"},
      {:mint, "~> 1.4"},
      {:exonerate, "~> 0.2.2"},
      {:mock, "~> 0.3.7", only: :test},
      {:castore, "~> 0.1.0"},
      {:config_tuples, "~> 0.4.2"},
      {:mongodb, "~> 1.0.0-beta.1"},
      {:decimal, "~> 2.0.0"},
      {:jason, "~> 1.2.0"},
      #{:trx_logging,
      # git: @integration_toolkit_repo, tag: @integration_toolkit_version, sparse: "trx_logging"},
      {:uuid, "~> 1.1"},
      {:telemetry, "~> 1.0"},
      {:telemetry_metrics, "~> 0.6.1"},
      {:telemetry_metrics_prometheus, "~> 1.1.0"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/adapters"]
  defp elixirc_paths(_), do: ["lib"]
end
