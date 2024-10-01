defmodule Finix.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_finix,
      version: "0.1.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
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
      {:tesla, ">= 0.0.0", optional: true},
      {:hackney, ">= 0.0.0", optional: true},
      {:jason, ">= 1.0.0", optional: true},
      {:ecto, ">= 3.0.0"},
      {:ecto_enum, "~> 1.4"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
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

  defp docs do
    [
      main: "readme",
      source_url: "https://github.com/kodyberry23/ex_finix",
      source_ref: "v0.1.0",
      extras: ["README.md", "LICENSE.md"],
      groups_for_modules: [
        Authorizations: [Finix.Authorizations.Authorization],
        Identities: [Finix.Identities.Identity],
        Merchants: [Finix.Merchants.Merchant],
        PaymentInstruments: [Finix.PaymentInstruments.PaymentInstrument],
        Transfers: [Finix.Transfers.Transfer],
        Verifications: [Finix.Verifications.Verification]
      ],
      nest_modules_by_prefix: [
        Finix.Authorizations,
        Finix.Identities,
        Finix.Merchants,
        Finix.PaymentInstruments,
        Finix.Transfers,
        Finix.Verifications
      ]
    ]
  end
end
