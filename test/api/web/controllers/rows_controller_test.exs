defmodule Api.Web.RowsControllerTest do
  use Api.Web.ConnCase

  alias Api.Content
  alias Api.Content.Rows

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:rows) do
    {:ok, rows} = Content.create_rows(@create_attrs)
    rows
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, rows_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates rows and renders rows when data is valid", %{conn: conn} do
    conn = post conn, rows_path(conn, :create), rows: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, rows_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "body" => "some body",
      "title" => "some title"}
  end

  test "does not create rows and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, rows_path(conn, :create), rows: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen rows and renders rows when data is valid", %{conn: conn} do
    %Rows{id: id} = rows = fixture(:rows)
    conn = put conn, rows_path(conn, :update, rows), rows: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, rows_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "body" => "some updated body",
      "title" => "some updated title"}
  end

  test "does not update chosen rows and renders errors when data is invalid", %{conn: conn} do
    rows = fixture(:rows)
    conn = put conn, rows_path(conn, :update, rows), rows: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen rows", %{conn: conn} do
    rows = fixture(:rows)
    conn = delete conn, rows_path(conn, :delete, rows)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, rows_path(conn, :show, rows)
    end
  end
end
