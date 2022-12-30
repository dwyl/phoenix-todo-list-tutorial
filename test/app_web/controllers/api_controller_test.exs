defmodule AppWeb.ApiControllerTest do
  use AppWeb.ConnCase
  alias App.Todo

  @create_attrs %{person_id: 42, status: 0, text: "some text"}
  @update_attrs %{person_id: 43, status: 0, text: "some updated text"}
  @update_status_attrs %{status: 1}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}
  @invalid_status_attrs %{status: 6}

  describe "list" do
    test "all items", %{conn: conn} do
      {:ok, _item} = Todo.create_item(@create_attrs)

      conn = get(conn, ~p"/api/items")

      assert conn.status == 200
      assert length(Jason.decode!(response(conn, 200))) == 0
    end
  end

  describe "create" do
    test "a valid item", %{conn: conn} do
      conn = post(conn, ~p"/api/items", @create_attrs)

      assert conn.status == 200
      assert Map.get(Jason.decode!(response(conn, 200)), :text) == Map.get(@create_attrs, "text")

      assert Map.get(Jason.decode!(response(conn, 200)), :status) ==
               Map.get(@create_attrs, "status")

      assert Map.get(Jason.decode!(response(conn, 200)), :person_id) ==
               Map.get(@create_attrs, "person_id")
    end

    test "an invalid item", %{conn: conn} do
      conn = post(conn, ~p"/api/items", @invalid_attrs)

      assert conn.status == 400

      error_text = response(conn, 400) |> Jason.decode!() |> Map.get("text")
      assert error_text == ["can't be blank"]
    end
  end

  describe "update" do
    test "item with valid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}", @update_attrs)
      assert conn.status == 200
      assert Map.get(Jason.decode!(response(conn, 200)), :text) == Map.get(@update_attrs, "text")
    end

    test "item with invalid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}", @invalid_attrs)

      assert conn.status == 400
      error_text = response(conn, 400) |> Jason.decode!() |> Map.get("text")
      assert error_text == ["can't be blank"]
    end
  end

  describe "update item status" do
    test "with valid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}/status", @update_status_attrs)
      assert conn.status == 200

      assert Map.get(Jason.decode!(response(conn, 200)), :status) ==
               Map.get(@update_status_attrs, "status")
    end

    test "with invalid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}/status", @invalid_status_attrs)

      assert conn.status == 400
      error_text = response(conn, 400) |> Jason.decode!() |> Map.get("status")
      assert error_text == ["must be less than or equal to 2"]
    end
  end
end
