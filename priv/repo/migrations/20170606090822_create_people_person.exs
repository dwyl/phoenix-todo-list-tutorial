defmodule Api.Repo.Migrations.CreateApi.People.Person do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      timestamps()
    end

    create unique_index(:people, [:email])

  end
end
