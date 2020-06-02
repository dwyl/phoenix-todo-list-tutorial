defmodule AppWeb.ItemControllerTest do
  use AppWeb.ConnCase

  alias App.Todo

  @create_attrs %{person_id: 0, status: 0, text: "some text"}
  @update_attrs %{person_id: 0, status: 1, text: "some updated text"}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}

  def fixture(:item) do
    {:ok, item} = Todo.create_item(@create_attrs)
    item
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :index))
      assert html_response(conn, 200) =~ "todos"
    end
  end

  describe "new item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Item"
    end
  end

  describe "create item" do
    test "redirects to :index page when item data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)

      assert redirected_to(conn) == Routes.item_path(conn, :index)
      assert html_response(conn, 302) =~ "redirected"

      conn = get(conn, Routes.item_path(conn, :index))
      assert html_response(conn, 200) =~ @create_attrs.text
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Item"
    end
  end

  describe "edit item" do
    setup [:create_item]

    test "renders form for editing chosen item", %{conn: conn, item: item} do
      conn = get(conn, Routes.item_path(conn, :edit, item))
      assert html_response(conn, 200) =~ item.text
    end
  end

  describe "update item" do
    setup [:create_item]

    test "redirects when data is valid", %{conn: conn, item: item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @update_attrs)
      assert redirected_to(conn) == Routes.item_path(conn, :index)

      conn = get(conn, Routes.item_path(conn, :show, item))
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Item"
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.item_path(conn, :delete, item))
      conn = get(conn, Routes.item_path(conn, :show, item))
      # Status: 2
      assert html_response(conn, 200) =~ "2"
    end
  end

  describe "toggle updates the status of an item 0 > 1 | 1 > 0" do
    setup [:create_item]

    test "toggle_status/1 item.status 1 > 0", %{item: item} do
      assert item.status == 0
      # first toggle
      toggled_item = %{item | status: AppWeb.ItemController.toggle_status(item)}
      assert toggled_item.status == 1
      # second toggle sets status back to 0
      assert AppWeb.ItemController.toggle_status(toggled_item) == 0
    end

    test "toggle/2 updates an item.status 0 > 1", %{conn: conn, item: item} do
      assert item.status == 0
      get(conn, Routes.item_path(conn, :toggle, item.id))
      toggled_item = Todo.get_item!(item.id)
      assert toggled_item.status == 1
    end
  end

  describe "clear_completed/2" do
    setup [:create_item]

    test "clear_completed/2", %{conn: conn, item: item} do
      get(conn, Routes.item_path(conn, :toggle, item.id))
      conn = get(conn, Routes.item_path(conn, :clear_completed))
      updated_item = App.Todo.get_item!(item.id)
      assert updated_item.status == 2
    end
  end

  defp create_item(_) do
    item = fixture(:item)
    %{item: item}
  end
end
