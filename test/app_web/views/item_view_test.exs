defmodule AppWeb.ItemViewTest do
  use AppWeb.ConnCase, async: true
  alias AppWeb.ItemView

  test "complete/1 returns completed if item.status == 1" do
    assert ItemView.complete(%{status: 1}) == "completed"
  end

  test "complete/1 returns empty string if item.status == 0" do
    assert ItemView.complete(%{status: 0}) == ""
  end

  test "checked/1 returns checked if item.status == 1" do
    assert ItemView.checked(%{status: 1}) == "checked"
  end

  test "checked/1 returns empty string if item.status == 0" do
    assert ItemView.checked(%{status: 0}) == ""
  end
end
