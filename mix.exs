defmodule IOT.Mixfile do
  use Mix.Project

  def project() do
    [
      app: :iot,
      version: "0.7.1",
      elixir: "~> 1.7",
      description: "IoT Device Management Platform",
      package: package(),
      deps: deps()
    ]
  end

  def package do
    [
      files: ~w(doc src lib include mix.exs README* LICENSE),
      licenses: ["ISC"],
      maintainers: ["Namdak Tonpa"],
      name: :iot,
      links: %{"GitHub" => "https://github.com/enterprizing/iot"}
    ]
  end

  def application() do
    [
      mod: {:iot, []},
       applications: [:rocksdb, :kvs]
    ]
  end

  def deps() do
    [
      {:ex_doc, "~> 0.20.2", only: :dev},
      {:rocksdb, "~> 1.2.0"},
      {:kvs, "~> 6.7.6"}
    ]
  end
end
