defmodule App.CtxTest do
  use App.DataCase

  alias App.Ctx

  describe "items" do
    alias App.Ctx.Item

    @valid_attrs %{person_id: 42, status: 42, text: "some text"}
    @update_attrs %{person_id: 43, status: 43, text: "some updated text"}
    @invalid_attrs %{person_id: nil, status: nil, text: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ctx.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Ctx.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Ctx.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Ctx.create_item(@valid_attrs)
      assert item.person_id == 42
      assert item.status == 42
      assert item.text == "some text"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ctx.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Ctx.update_item(item, @update_attrs)
      assert item.person_id == 43
      assert item.status == 43
      assert item.text == "some updated text"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Ctx.update_item(item, @invalid_attrs)
      assert item == Ctx.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Ctx.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Ctx.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Ctx.change_item(item)
    end
  end
end
