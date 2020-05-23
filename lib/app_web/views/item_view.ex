defmodule AppWeb.ItemView do
  use AppWeb, :view

  # add class "completed" to a list item if item.status=1
  def complete(item) do
    case item.status do
      1 -> "completed"
      _ -> "" # empty string means empty class so no style applied
    end
  end

  # add checked="true" to input if item.status=1
  def checked(item) do
    case item.status do
      1 -> "true"
      _ -> "" # empty string means empty class so no style applied
    end
  end

end
