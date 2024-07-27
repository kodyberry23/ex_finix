defmodule Finix.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_finix,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Finix",
      source_url: "https://github.com/kodyberry23/ex_finix"
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
      {:tesla, "~> 1.9"},
      {:hackney, "~> 1.20"},
      {:jason, "~> 1.4"},
      {:ecto, "~> 3.10"},
      {:ecto_enum, "~> 1.4"}
    ]
  end

  defp description() do
    "Finix API client library for Elixir."
  end

  defp package() do
    [
      maintainers: ["Kody Berry"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kodyberry23/ex_finix"}
    ]
  end
end
