defmodule Api.People.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.People.Person


  schema "people" do
    field :email, :string
    field :name, :string
    has_many :content, Api.Content.Rows, foreign_key: :people_people_id

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
