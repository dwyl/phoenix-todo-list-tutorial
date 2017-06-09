defmodule Api.Content do
  @moduledoc """
  The boundary for the Content system.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Content.Rows

  @doc """
  Returns the list of rows.

  ## Examples

      iex> list_rows()
      [%Rows{}, ...]

  """
  def list_rows do
    Repo.all(Rows)
  end

  @doc """
  Gets a single rows.

  Raises `Ecto.NoResultsError` if the Rows does not exist.

  ## Examples

      iex> get_rows!(123)
      %Rows{}

      iex> get_rows!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rows!(id), do: Repo.get!(Rows, id)

  @doc """
  Creates a rows.

  ## Examples

      iex> create_rows(%{field: value})
      {:ok, %Rows{}}

      iex> create_rows(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rows(attrs \\ %{}) do
    %Rows{}
    |> Rows.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rows.

  ## Examples

      iex> update_rows(rows, %{field: new_value})
      {:ok, %Rows{}}

      iex> update_rows(rows, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rows(%Rows{} = rows, attrs) do
    rows
    |> Rows.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Rows.

  ## Examples

      iex> delete_rows(rows)
      {:ok, %Rows{}}

      iex> delete_rows(rows)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rows(%Rows{} = rows) do
    Repo.delete(rows)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rows changes.

  ## Examples

      iex> change_rows(rows)
      %Ecto.Changeset{source: %Rows{}}

  """
  def change_rows(%Rows{} = rows) do
    Rows.changeset(rows, %{})
  end
end
