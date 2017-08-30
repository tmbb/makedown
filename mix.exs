defmodule Makedown.Mixfile do
  use Mix.Project

  def project do
    [
      app: :makedown,
      version: "0.2.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [
        source_url: "https://github.com/tmbb/makedown",
        homepage_url: "https://github.com/tmbb/makedown",
        extras: ["README.md"]
      ],
      # Package
      package: package(),
      description: description()
    ]
  end

  defp description do
    """
    Markdown implementation that uses Makeup for syntax highlighting.
    """
  end

  defp package do
    [
      name: :makedown,
      licenses: ["BSD"],
      maintainers: ["Tiago Barroso <tmbb@campus.ul.pt>"],
      links: %{"GitHub" => "https://github.com/tmbb/makedown"}
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
      {:makeup, "~> 0.2.0"},
      {:earmark, "~> 1.1"},
      {:ex_doc, "~> 0.16.3", only: :dev, runtime: false}
      #{:ex_doc, github: "elixir-lang/ex_doc", only: :dev, runtime: false}
    ]
  end
end
