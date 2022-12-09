defmodule App.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :text, :string
      add :person_email, :string
      add :status, :integer

      timestamps()
    end
  end
end
