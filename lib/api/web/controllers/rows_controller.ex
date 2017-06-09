defmodule Api.Web.RowsController do
  use Api.Web, :controller

  alias Api.Content
  alias Api.Content.Rows

  action_fallback Api.Web.FallbackController

  def index(conn, _params) do
    rows = Content.list_rows()
    render(conn, "index.json", rows: rows)
  end

  def create(conn, %{"rows" => rows_params}) do
    with {:ok, %Rows{} = rows} <- Content.create_rows(rows_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", rows_path(conn, :show, rows))
      |> render("show.json", rows: rows)
    end
  end

  def show(conn, %{"id" => id}) do
    rows = Content.get_rows!(id)
    render(conn, "show.json", rows: rows)
  end

  def update(conn, %{"id" => id, "rows" => rows_params}) do
    rows = Content.get_rows!(id)

    with {:ok, %Rows{} = rows} <- Content.update_rows(rows, rows_params) do
      render(conn, "show.json", rows: rows)
    end
  end

  def delete(conn, %{"id" => id}) do
    rows = Content.get_rows!(id)
    with {:ok, %Rows{}} <- Content.delete_rows(rows) do
      send_resp(conn, :no_content, "")
    end
  end
end
