defmodule Api.Web.RowsView do
  use Api.Web, :view
  alias Api.Web.RowsView

  def render("index.json", %{rows: rows}) do
    %{data: render_many(rows, RowsView, "rows.json")}
  end

  def render("show.json", %{rows: rows}) do
    %{data: render_one(rows, RowsView, "rows.json")}
  end

  def render("rows.json", %{rows: rows}) do
    %{id: rows.id,
      title: rows.title,
      body: rows.body}
  end
end
