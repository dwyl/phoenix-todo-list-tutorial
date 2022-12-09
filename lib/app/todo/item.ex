defmodule App.Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :person_email, :string, default: ""
    field :status, :integer, default: 0
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:person_email, :status, :text])
    |> validate_required([:person_email, :text])
  end
end
