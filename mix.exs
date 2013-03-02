defmodule Tinymd.Mixfile do
  use Mix.Project

  def project do
    [ app: :tinymd,
      version: "0.0.1",
      dynamos: [Tinymd.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/tinymd/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { Tinymd, [] } ]
  end

  defp deps do
    [ { :ranch, %r(.*), github: "extend/ranch" },
      { :cowboy, %r(.*), github: "extend/cowboy" },
#      { :cowboy, %r(0.8.0), github: "extend/cowboy", tags: "0.8.0" },
      { :dynamo, %r(.*), github: "elixir-lang/dynamo" } ]
  end
end
