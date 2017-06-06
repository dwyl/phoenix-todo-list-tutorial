defmodule Api.Schema do
  use Absinthe.Schema
  import_types Api.Schema.Types

  query do
    field :content, list_of(:content) do
      resolve &Api.Content.RowsResolver.all/2
    end

    field :people, list_of(:people) do
      resolve &Api.People.PeopleResolver.all/2
    end
  end

end
