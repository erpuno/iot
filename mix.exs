defmodule IoT.Mixfile do
  use Mix.Project

  def project() do
    [
      app: :iot,
      version: "0.7.0",
      elixir: "~> 1.7",
      description: "IoT Device Management Platform",
      package: package(),
      deps: deps()
    ]
  end

  def package do
    [
      files: ~w(doc src mix.exs LICENSE),
      licenses: ["ISC"],
      maintainers: ["Namdak Tonpa"],
      name: :iot,
      links: %{"GitHub" => "https://github.com/enterprizing/iot"}
    ]
  end

  def application() do
    [mod: {:iot, []}]
  end

  def deps() do
    [
      {:ex_doc, "~> 0.20.2", only: :dev}
    ]
  end
end
