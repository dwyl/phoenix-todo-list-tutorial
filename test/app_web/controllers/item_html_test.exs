defmodule AppWeb.ItemHTMLTest do
  use AppWeb.ConnCase, async: true
  alias AppWeb.ItemHTML
  alias AppWeb.Router.Helpers, as: Routes

  test "complete/1 returns completed if item.status == 1" do
    assert ItemHTML.complete(%{status: 1}) == "completed"
  end

  test "complete/1 returns empty string if item.status == 0" do
    assert ItemHTML.complete(%{status: 0}) == ""
  end

  test "remaining_items/1 returns count of items where item.status==0" do
    items = [
      %{text: "one", status: 0},
      %{text: "two", status: 0},
      %{text: "done", status: 1}
    ]
    assert ItemHTML.remaining_items(items) == 2
  end

  test "remaining_items/1 returns 0 (zero) when no items are status==0" do
    items = []
    assert ItemHTML.remaining_items(items) == 0
  end
end
