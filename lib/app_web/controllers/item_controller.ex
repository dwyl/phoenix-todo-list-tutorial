defmodule AppWeb.ItemController do
  use AppWeb, :controller

  alias App.Ctx
  alias App.Ctx.Item

  def index(conn, params) do
    item =
      if not is_nil(params) and Map.has_key?(params, "id") do
        Ctx.get_item!(params["id"])
      else
        %Item{}
      end

    items = Ctx.list_items()
    changeset = Ctx.change_item(item)

    render(conn, "index.html",
      items: items,
      changeset: changeset,
      editing: item,
      filter: Map.get(params, "filter", "all")
    )
  end

  def new(conn, _params) do
    changeset = Ctx.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    case Ctx.create_item(item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: Routes.item_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Ctx.get_item!(id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, params) do
    index(conn, params)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Ctx.get_item!(id)

    case Ctx.update_item(item, item_params) do
      {:ok, _item} ->
        conn
        # |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: Routes.item_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Ctx.get_item!(id)
    {:ok, _item} = Ctx.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: Routes.item_path(conn, :index))
  end

  def toggle_status(item) do
    case item.status do
      1 -> 0
      0 -> 1
    end
  end

  def toggle(conn, %{"id" => id}) do
    item = Ctx.get_item!(id)
    Ctx.update_item(item, %{status: toggle_status(item)})
    redirect(conn, to: Routes.item_path(conn, :index))
  end
end
