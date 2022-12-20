Envar.require_env_file('.env_sample')
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(App.Repo, :manual)
