defmodule AppWeb.ItemHTML do
  use AppWeb, :html

  embed_templates "item_html/*"

  # add class "completed" to a list item if item.status=1
  def complete(item) do
    case item.status do
      1 -> "completed"
      _ -> "" # empty string means empty class so no style applied
    end
  end

  # returns integer value of items where item.status == 0 (not "done")
  def remaining_items(items) do
    Enum.filter(items, fn i -> i.status == 0 end) |> Enum.count
  end

  def filter(items, str) do
    case str do
      "items" -> Enum.filter(items, fn i -> i.status !== 2 end)
      "active" -> Enum.filter(items, fn i -> i.status == 0 end)
      "completed" -> Enum.filter(items, fn i -> i.status == 1 end)
      _ -> Enum.filter(items, fn i -> i.status !== 2 end)
    end
  end
end
