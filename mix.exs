defmodule Makedown.Mixfile do
  use Mix.Project

  def project do
    [
      app: :makedown,
      version: "0.1.0",
      elixir: "~> 1.5-rc",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [
        source_url: "https://github.com/tmbb/makedown",
        homepage_url: "https://github.com/tmbb/makedown",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:makeup, "~> 0.1.3"},
      {:earmark, "~> 1.1"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
