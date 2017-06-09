defmodule Api.Content.Rows do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Content.Rows


  schema "content" do
    field :body, :string
    field :title, :string
    belongs_to :people, Api.People.Person, foreign_key: :people_id

    timestamps()
  end

  @doc false
  def changeset(%Rows{} = rows, attrs) do
    rows
    |> cast(attrs, [:title, :body, :people_id])
    |> validate_required([:title, :body])
  end
end
