defmodule Api.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Api.Repo

  object :people do
    field :id, :id
    field :name, :string
    field :email, :string
    field :rows, list_of(:content), resolve: assoc(:content)
  end

  object :content do
    field :id, :id
    field :title, :string
    field :body, :string
    field :people_id, :people, resolve: assoc(:people)
  end
end
