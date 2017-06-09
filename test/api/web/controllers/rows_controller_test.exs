defmodule Api.Web.RowsControllerTest do
  use Api.Web.ConnCase

  alias Api.Content
  alias Api.Content.Rows
  alias Api.People
  # alias Api.Repo

  @create_attrs %{body: "some body", title: "some title", people_id: "1"}
  @update_attrs %{body: "some updated body",
    title: "some updated title", people_id: "1"}
  @invalid_attrs %{body: nil, title: nil}
  @n 100000000000000
  @valid_person %{name: "Jimmy", email: "jimmy@dwyl.io"}

  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{ @valid_person | email:
        @valid_person.email <> Integer.to_string(:rand.uniform(@n)) })
      # |> Repo.preload(content: :content)
      |> People.create_person()

    person
  end

  def valid_row_fixture() do
    person = person_fixture()
    valid_row = %{@create_attrs | people_id: person.id }

    valid_row
  end

  def fixture(:rows) do
    row = valid_row_fixture()
    {:ok, rows} = Content.create_rows(row)
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

    person = person_fixture()


    conn = post conn, rows_path(conn, :create),
      rows: %{@create_attrs | people_id: person.id}
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, rows_path(conn, :show, id)
    res = json_response(conn, 200)["data"]

    assert res == %{
      "id" => id,
      "body" => "some body",
      "title" => "some title",
      "people_id" => person.id,
      "inserted_at" => res.inserted_at # is there a better way to do this?
    }
  end

  test "does not create rows and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, rows_path(conn, :create), rows: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen row and renders row when data is valid", %{conn: conn} do
    %Rows{id: id} = rows = fixture(:rows)
    person = person_fixture()
    # IO.puts "- - - - - - - person:"
    # IO.inspect person
    IO.puts "- - - - - - - person.id:"
    IO.inspect person.id

    conn = put conn, rows_path(conn, :update, rows),
      rows: %{@update_attrs | people_id: person.id}
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, rows_path(conn, :show, id)
    res = json_response(conn, 200)["data"]
    IO.puts "- - - - - - - res.inserted_at:"
    IO.inspect res
    assert res == %{
      "id" => id,
      "body" => "some updated body",
      "title" => "some updated title",
      "people_id" => person.id,
      "inserted_at" => res.inserted_at # is there a better way to do this?
    }
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
