defmodule Api.Repo.Migrations.CreateApi.People.Person do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
