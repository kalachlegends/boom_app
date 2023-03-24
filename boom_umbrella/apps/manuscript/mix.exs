defmodule Manuscript.MixProject do
  use Mix.Project

  def project do
    [
      app: :manuscript,
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
      mod: {Manuscript.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:ex_doc, "~> 0.28.4", only: :dev, runtime: false},
      {:earmark, "~> 1.4"},
      {:jason, "~> 1.3"}
    ]
  end
end
