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
    [ { :ranch, %r(.*), github: "extend/ranch", ref: "c3133bfbc324fbb9ac26ab689cd41dc362ad7c05" },
      { :cowboy, %r(.*), github: "extend/cowboy", ref: "a3049f7100bb9f3cbaef1db6bf6cdeb750d9e298" },
      { :dynamo, %r(.*), github: "elixir-lang/dynamo" },
      { :markdown, %r(.*), github: "k1complete/erlmarkdown", compile: "sh -c 'mkdir -p ebin; erlc -o ebin src/markdown.erl ; cp src/markdown.app.src ebin/markdown.app' ", branch: "unicode_option" },
      { :mix_task_heroku, %r(.*), github: "k1complete/mix_task_heroku" } ]
  end

end
