defmodule AppWeb.ItemView do
  use AppWeb, :view

  # add class "completed" to a list item if item.status=1
  def complete(item) do
    case item.status do
      1 -> "completed"
      # empty string means empty class so no style applied
      _ -> ""
    end
  end

  #  add "checked" to input if item.status=1
  def checked(item) do
    case item.status do
      1 -> "checked"
      # empty string means empty class so no style applied
      _ -> ""
    end
  end

  # returns integer value of items where item.status == 0 (not "done")
  def remaining_items(items) do
    Enum.filter(items, fn i -> i.status < 1 end) |> Enum.count()
  end

  # filter the items based on the filter string
  def filter(items, str) do
    case str do
      "all" -> Enum.filter(items, fn i -> i.status == 0 || i.status == 1 end)
      "active" -> Enum.filter(items, fn i -> i.status == 0 end)
      "completed" -> Enum.filter(items, fn i -> i.status == 1 end)
    end
  end

  def selected(filter, str) do
    case filter == str do
      true -> "selected"
      false -> ""
    end
  end

  # pluralise the word item when the number of items is greather/less than 1
  def pluralise(items) do
    # items where status < 1 is equal to Zero or Greater than One:
    case remaining_items(items) == 0 || remaining_items(items) > 1 do
      true -> "items"
      false -> "item"
    end
  end

  # check if there are items with status 0 or 1, used to hide/show footer
  def got_items?(items) do
    Enum.filter(items, fn i -> i.status < 2 end) |> Enum.count() > 0
  end
end
