defmodule AppWeb.ItemControllerTest do
  use AppWeb.ConnCase

  alias App.Ctx

  @create_attrs %{person_id: 0, status: 0, text: "some text"}
  @update_attrs %{person_id: 0, status: 1, text: "some updated text"}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}

  def fixture(:item) do
    {:ok, item} = Ctx.create_item(@create_attrs)
    item
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Items"
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
      assert html_response(conn, 200) =~ "Edit Item"
    end
  end

  describe "update item" do
    setup [:create_item]

    test "redirects when data is valid", %{conn: conn, item: item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @update_attrs)
      assert redirected_to(conn) == Routes.item_path(conn, :show, item)

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
      assert redirected_to(conn) == Routes.item_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.item_path(conn, :show, item))
      end
    end
  end

  describe "toggle/2 updates the status of an item 0 > 1" do
    setup [:create_item]

    test "toggle an item.status from 0 to 1", %{conn: conn, item: item} do
      IO.inspect(item, label: "item before toggle")
      assert item.status == 0
      conn = post(conn, Routes.item_path(conn, :toggle), item: item)
      toggled_item = Ctx.get_item!(item.id)
      IO.inspect(toggled_item, label: "toggled_item")
      # assert toggled_item.status == 1

      # assert redirected_to(conn) == Routes.item_path(conn, :index)
      # assert_error_sent 404, fn ->
      #   get(conn, Routes.item_path(conn, :show, item))
      # end
    end
  end

  defp create_item(_) do
    item = fixture(:item)
    %{item: item}
  end
end
