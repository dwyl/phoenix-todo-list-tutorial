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
end
