config :dynamo,
  # On production, modules are compiled up-front.
  compile_on_demand: false,
  reload_modules: false

config :server,
  port: binary_to_integer(System.get_env("PORT")) || 8080,
  acceptors: 100,
  max_connections: 10000

# config :ssl,
#  port: 8889,
#  keyfile: "/var/www/key.pem",
#  certfile: "/var/www/cert.pem"
