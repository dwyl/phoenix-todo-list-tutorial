defmodule Api.ContentTest do
  use Api.DataCase

  alias Api.Content

  describe "rows" do
    alias Api.Content.Rows

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def rows_fixture(attrs \\ %{}) do
      {:ok, rows} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_rows()

      rows
    end

    test "list_rows/0 returns all rows" do
      rows = rows_fixture()
      assert Content.list_rows() == [rows]
    end

    test "get_rows!/1 returns the rows with given id" do
      rows = rows_fixture()
      assert Content.get_rows!(rows.id) == rows
    end

    test "create_rows/1 with valid data creates a rows" do
      assert {:ok, %Rows{} = rows} = Content.create_rows(@valid_attrs)
      assert rows.body == "some body"
      assert rows.title == "some title"
    end

    test "create_rows/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_rows(@invalid_attrs)
    end

    test "update_rows/2 with valid data updates the rows" do
      rows = rows_fixture()
      assert {:ok, rows} = Content.update_rows(rows, @update_attrs)
      assert %Rows{} = rows
      assert rows.body == "some updated body"
      assert rows.title == "some updated title"
    end

    test "update_rows/2 with invalid data returns error changeset" do
      rows = rows_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_rows(rows, @invalid_attrs)
      assert rows == Content.get_rows!(rows.id)
    end

    test "delete_rows/1 deletes the rows" do
      rows = rows_fixture()
      assert {:ok, %Rows{}} = Content.delete_rows(rows)
      assert_raise Ecto.NoResultsError, fn -> Content.get_rows!(rows.id) end
    end

    test "change_rows/1 returns a rows changeset" do
      rows = rows_fixture()
      assert %Ecto.Changeset{} = Content.change_rows(rows)
    end
  end
end
