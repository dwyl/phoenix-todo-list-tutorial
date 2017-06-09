defmodule Api.People.PeopleResolver do
  alias Api.{People.Person, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Person)}
  end

end
