defmodule Api.People.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.People.Person


  schema "people" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    has_many :content, Api.Content.Rows, foreign_key: :people_people_id

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:name, :email]) #, :password_hash])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
