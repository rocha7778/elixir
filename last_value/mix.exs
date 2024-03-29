defmodule LastValue.MixProject do
  use Mix.Project

  def project do
    [
      app: :last_value,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {LastValue.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:telemetry, "~> 1.0"},
      {:telemetry_metrics, "~> 0.6.1"},
      {:telemetry_metrics_prometheus, "~> 1.1.0"},
    ]
  end
end
