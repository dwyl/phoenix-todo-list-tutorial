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
end
