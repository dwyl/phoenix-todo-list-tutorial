defmodule Api.Web.PersonControllerTest do
  use Api.Web.ConnCase

  alias Api.People
  alias Api.People.Person

  @create_attrs %{email: "some email", name: "some name"}
  @update_attrs %{email: "some updated email", name: "some updated name"}
  @invalid_attrs %{email: nil, name: nil}

  def fixture(:person) do
    {:ok, person} = People.create_person(@create_attrs)
    person
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, person_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates person and renders person when data is valid", %{conn: conn} do
    conn = post conn, person_path(conn, :create), person: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, person_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some email",
      "name" => "some name"}
  end

  test "does not create person and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, person_path(conn, :create), person: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen person and renders person when data is valid", %{conn: conn} do
    %Person{id: id} = person = fixture(:person)
    conn = put conn, person_path(conn, :update, person), person: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, person_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some updated email",
      "name" => "some updated name"}
  end

  test "does not update chosen person and renders errors when data is invalid", %{conn: conn} do
    person = fixture(:person)
    conn = put conn, person_path(conn, :update, person), person: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen person", %{conn: conn} do
    person = fixture(:person)
    conn = delete conn, person_path(conn, :delete, person)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, person_path(conn, :show, person)
    end
  end
end
