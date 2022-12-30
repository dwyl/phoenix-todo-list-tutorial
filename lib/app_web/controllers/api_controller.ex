defmodule AppWeb.ApiController do
  use AppWeb, :controller
  alias App.Todo
  import Ecto.Changeset

  def index(conn, _params) do
    items = Todo.list_items()
    json(conn, items)
  end

  def create(conn, params) do
    case Todo.create_item(params) do
      # Successfully creates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def update(conn, params) do
    id = Map.get(params, "id")
    text = Map.get(params, "text", "")

    item = Todo.get_item!(id)

    case Todo.update_item(item, %{text: text}) do
      # Successfully updates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def update_status(conn, params) do
    id = Map.get(params, "id")
    status = Map.get(params, "status", "")

    item = Todo.get_item!(id)

    case Todo.update_item(item, %{status: status}) do
      # Successfully updates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  defp make_errors_readable(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
