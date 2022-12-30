<div align="center">

# Create a Basic `REST` API to Return `JSON` Data

</div>

This guide demonstrates
how to *extend* a `Phoenix` App
so it also acts as an **API** 
returning `JSON` data.

## Add `/api` scope and pipeline

Open the 
`lib/router.ex` file.
There is already a
`pipeline :browser` 
that is used inside the `scope "/"`.

```elixir
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", AppWeb do
    pipe_through :browser

    get "/", ItemController, :index
    get "/items/toggle/:id", ItemController, :toggle
    get "/items/clear", ItemController, :clear_completed
    get "/items/:filter", ItemController, :index
    resources "/items", ItemController
  end
```

What this means is that
every time a request is made 
to any of the aforementioned endpoints,
the pipeline `:browser` acts as a *middleware*,
going through each `plug` defined. 
Check the first plug.
It says `plug :accepts, ["html"]`.
It means it only accepts requests
to return an HTML page.

We want to do something similar to all of this,
but to return a `JSON` object.
For this, 
add the following piece of code.

```elixir
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppWeb do
    pipe_through :api

    put "/items/:id/status", ApiController, :update_status
    resources "items", ApiController, only: [:create, :update, :index]
  end
```

This creates a pipeline `:api`
that only accepts requests for `JSON` data.

We have also added a scope.
All routes starting with `/api`
will be piped through with the 
`:api` pipeline 
and handled by the `ApiController`.
Speaking of which, 
let's create it!

## Create the API Controller

Before creating our controller,
let's define our requirements.
We want the API to:

- list `item`s
- create an `item`
- edit an `item`
- update an `item`'s status

We want each endpoint to respond appropriately
if any data is invalid,
the response body and status
should inform the user what went wrong.
We can leverage `changesets` 
to validate the `Item` 
and check if it's correctly formatted.

Since we now know what to do,
let's create our tests.

### Adding Tests

Before writing tests,
we need to change the 
`test/support/fixtures/todo_fixtures.ex` file.
This file contains a function
that is used to create an `Item` for testing.

Currently, the returned default `Item` is invalid.
This is because it returns a `status: 42`, 
which according to our requirements, 
doesn't make sense.
The `status` field can only be `0`, `1` or `2`.

Change the `item_fixture/1` function
so it looks like this:

```elixir
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        person_id: 42,
        status: 0,
        text: "some text"
      })
      |> App.Todo.create_item()
    item
  end
```

Now, let's create
our controller tests.
Create a file with the path: 
`test/app_web/controllers/api_controller_test.exs`
and add the following code:

```elixir
defmodule AppWeb.ApiControllerTest do
  use AppWeb.ConnCase
  alias App.Todo

  @create_attrs %{person_id: 42, status: 0, text: "some text"}
  @update_attrs %{person_id: 43, status: 0, text: "some updated text"}
  @update_status_attrs %{status: 1}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}
  @invalid_status_attrs %{status: 6}

  describe "list" do
    test "all items", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)
      conn = get(conn, ~p"/api/items")

      assert conn.status == 200
      assert length(Jason.decode!(response(conn, 200))) == 1
    end
  end

  describe "create" do
    test "a valid item", %{conn: conn} do
      conn = post(conn, ~p"/api/items", @create_attrs)

      assert conn.status == 200
      assert Map.get(Jason.decode!(response(conn, 200)), :text) == Map.get(@create_attrs, "text")

      assert Map.get(Jason.decode!(response(conn, 200)), :status) ==
               Map.get(@create_attrs, "status")

      assert Map.get(Jason.decode!(response(conn, 200)), :person_id) ==
               Map.get(@create_attrs, "person_id")
    end

    test "an invalid item", %{conn: conn} do
      conn = post(conn, ~p"/api/items", @invalid_attrs)

      assert conn.status == 400

      error_text = response(conn, 400) |> Jason.decode!() |> Map.get("text")
      assert error_text == ["can't be blank"]
    end
  end

  describe "update" do
    test "item with valid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}", @update_attrs)
      assert conn.status == 200
      assert Map.get(Jason.decode!(response(conn, 200)), :text) == Map.get(@update_attrs, "text")
    end

    test "item with invalid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}", @invalid_attrs)

      assert conn.status == 400
      error_text = response(conn, 400) |> Jason.decode!() |> Map.get("text")
      assert error_text == ["can't be blank"]
    end
  end

  describe "update item status" do
    test "with valid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}/status", @update_status_attrs)
      assert conn.status == 200

      assert Map.get(Jason.decode!(response(conn, 200)), :status) ==
               Map.get(@update_status_attrs, "status")
    end

    test "with invalid attributes", %{conn: conn} do
      {:ok, item} = Todo.create_item(@create_attrs)

      conn = put(conn, ~p"/api/items/#{item.id}/status", @invalid_status_attrs)

      assert conn.status == 400
      error_text = response(conn, 400) |> Jason.decode!() |> Map.get("status")
      assert error_text == ["must be less than or equal to 2"]
    end
  end
end
```

Let's break down what we just wrote.
We've created constants for each scenario we want:
testing valid or invalid attributes 
for each endpoint:
- `create`, referring to creating an `Item`.
- `update`, referring to updating an `Item`'s text.
- `update_status`, referring to updating an `Item`'s status.

The `ApiController` will have these three functions.
Let's look at the `describe "create"` suite.
The first test checks if a **valid `item`** is created.
If it is created, 
the item should be returned to the user in `JSON` format.
The second test checks if an **_invalid_ `item`**
was attempted to be created.
It should return a response with 
[HTTP Status Code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
`400` (meaning the client made a bad request)
and an error text accompanying the body.
These tests are replicated
on the other two functions.

If you run the tests `mix test`,
they will fail, 
because these functions aren't defined.

### Create API Controller

Let's create our API controller.
Inside `lib/app_web/controllers`,
create a file called 
`api_controller.ex`.

Use the following code.

```elixir
defmodule AppWeb.ApiController do
  use AppWeb, :controller
  alias App.Todo
  import Ecto.Changeset

  def index(conn, params) do
    items = Todo.list_items()
    json(conn, items)
  end

  def create(conn, params) do
    case Todo.create_item(params) do
      # Successfully creates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def update(conn, params) do
    id = Map.get(params, "id")
    text = Map.get(params, "text", "")

    item = Todo.get_item!(id)

    case Todo.update_item(item, %{text: text}) do
      # Successfully updates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def update_status(conn, params) do
    id = Map.get(params, "id")
    status = Map.get(params, "status", "")

    item = Todo.get_item!(id)

    case Todo.update_item(item, %{status: status}) do
      # Successfully updates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  defp make_errors_readable(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
```

We have created three functions, 
each coresponding to the endpoints 
`[:create, :update, :index]`
we defined earlier in `router.ex`.
They all follow the same flow:
try to do an action;
if it fails, return an error to the user.

Let's review the `update/2` function.
The `params` parameter gives us information
about the body of the request 
and the URL parameter.
Since the user accesses `/api/items/:id`,
an `id` field is present in the `params` map.
Similarly, the user sends a body
with the new text.

```json
{
    "text": "new text"
}
```

which can be accessed as `params.text`.

Next, we use the passed `id` 
to check and fetch the item from the database.
After this, we pass the fetched item
with the new `text` to update 
(calling `Todo.update_item`).

Depending on the success of the operation,
different results are returned to the user.
If it succeeds, 
the updated item is returned to the user,
alongside an HTTP status code of `200`.
On the other hand, if there's an error,
an error is returned to the user,
alongside an HTTP status code of `400`.

The error is fetched from the changeset
(that validates the passed attributes)
and made readable by the
`make_errors_readable/1` function.
You don't need to know about the details,
it just fetches the errors from the `changeset` struct
and converts it to a map that can be
serializable to JSON format.

If we use 
[Postman](https://www.postman.com/)
to make an API call, 
you will see the API in action.

> Postman is a tool 
that makes it easy to test API requests.

<img width="1359" alt="update_postman" src="https://user-images.githubusercontent.com/17494745/207413579-c75c8b2a-196b-41e0-9ad3-36c187730808.png">

## Adding validations to `Item` changeset

There's one last thing we need to change.
We want to add validations to the `Item` changeset
so we can make sure the `Item` is valid 
before adding it to the database.
We also want the user to receive useful information
if he unwillingly passed invalid attributes.

Open `lib/app/todo/item.ex`
and change `changeset/2` 
to the following.

```elixir
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :person_id, :status])
    |> validate_required([:text])
    |> validate_number(:status, greater_than_or_equal_to: 0, less_than_or_equal_to: 2)
    |> validate_length(:text, min: 0)
  end
```

We are now verifying 
if the `status` number is between `0` and `1`
and checking the length of the `text` to be updated.

This is great. 
*However*, a `changeset` struct 
is not serializable to `JSON`.
We need to tell the `JSON` serializer
which fields we want to retain in the `Item` schema.

For this,
we need to add
the following annotation 
on top of the schema definition 
inside `lib/app/todo/item.ex`.

```elixir
  @derive {Jason.Encoder, only: [:id, :person_id, :status, :text]}
  schema "items" do
    field :person_id, :integer, default: 0
    field :status, :integer, default: 0
    field :text, :string
    timestamps()
  end
```

We are telling the `Jason` library 
that when encoding or decoding `Item` structs,
we are only interested in the
`id`, `person_id`, `status` and `text` fields
(instead of other fields like
`updated_at`, `inserted_at` or `__meta__`).

## Congratulations!

Congratulations, 
you just added REST API capabilities 
to your `Phoenix` server!
It now serves a Todo application
**and** also serves an API for people to use it.

## Try It!

> update this section once the API is deployed to Fly.io ...
