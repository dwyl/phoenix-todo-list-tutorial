defmodule Api.Content.RowsResolver do
  alias Api.{Content.Rows, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Rows)}
  end
end
