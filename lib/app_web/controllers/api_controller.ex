defmodule AppWeb.ApiController do
  use AppWeb, :controller
  alias App.Todo
  import Ecto.Changeset

  def create(conn, params) do

    case Todo.create_item(params) do

      # Successfully creates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = traverse_errors(changeset, fn {msg, opts} ->
          Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
            opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
          end)
        end)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def edit(conn, params) do
    dbg("edit")
    conn
  end

end
