# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Api.Repo.delete_all Api.Users.User

Api.Users.User.changeset(%Api.Users.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> Api.Repo.insert!
|> Coherence.ControllerHelpers.confirm!
