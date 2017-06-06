defmodule Api.Web.Router do
  use Api.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Api.Web do
    pipe_through :api

    resources "/people", PersonController, except: [:new, :edit]
    resources "/rows", RowsController, except: [:new, :edit]
  end

  forward "/graph", Absinthe.Plug,
    schema: Api.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Api.Schema
end
