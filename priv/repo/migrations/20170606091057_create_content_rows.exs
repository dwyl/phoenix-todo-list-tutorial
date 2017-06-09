defmodule Api.Repo.Migrations.CreateApi.Content.Rows do
  use Ecto.Migration

  def change do
    create table(:content) do
      add :title, :string
      add :body, :text
      add :people_id, references(:people, on_delete: :nothing)

      timestamps()
    end

    create index(:content, [:people_id])
  end
end
