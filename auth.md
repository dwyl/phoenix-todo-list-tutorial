# Adding Authentication

This section of the tutorial
adds Authentication via 
[`auth_plug`](https://github.com/dwyl/auth_plug).
It's the fastest way to add 
[`auth`](https://github.com/dwyl/auth)
with the _fewest_ lines of code.

By the end you will be able to 
sign-in with Google or Github 
in your Todo List App.


## 1. Install `auth_plug`

Open `mix.exs` and locate the `deps` section.
Add the following line:

```elixir
{:auth_plug, "~> 1.5"},
```

Once you've saved the `mix.exs` file,
run:

```sh
mix deps.get
```

After installing, 
you need an `AUTH_API_KEY`.
To get this key, please follow 
the official instructions -> 
[Get your `AUTH_API_KEY`](https://github.com/dwyl/auth_plug#2-get-your-auth_api_key-)

Once you have created your `AUTH_API_KEY`, 
create an `.env` file in your project 
add the following line to it:

```sh
export AUTH_API_KEY=88SwQD4YweF8q7iAt1R/88SwQGcsdq4gUpR9D69DFAXy/authdemo.fly.dev
```

> **Note**: export the key you got from authdemo.fly.dev
> This is just for illustration. 

Once you've saved your `.env` file,
run:

```sh
source .env
```

## 2. Add _Optional_ Auth to `router.ex`


Open your 
`lib/app_web/router.ex`
and add the following lines:

definition with the following:

```elixir
  pipeline :authOptional, do: plug(AuthPlugOptional)

  scope "/", AppWeb do
    pipe_through [:browser, :authOptional]

    get "/", ItemController, :index

    # These are the auth specific routes:
    get "/login", AuthController, :login
    get "/logout", AuthController, :logout

    ...
  end
```

We just created the `:authOptional` pipeline 
that will run as **middleware**.
We additionally added two routes, 
one for `/login` and another to `/logout`.
They are managed by `AuthController`, 
which we will create now.

## 3. Create `auth_controller.ex`


Create the file:
`lib/app_web/controllers/auth_controller.ex`
and add the following lines of code:

```elixir
defmodule AppWeb.AuthController do
  use AppWeb, :controller

  def login(conn, _params) do
    redirect(conn, external: AuthPlug.get_auth_url(conn, ~p"/"))
  end

  def logout(conn, _params) do
    conn
    |> AuthPlug.logout()
    |> put_status(302)
    |> redirect(to: ~p"/items")
  end
end
```

When the user logs in, 
they are redirected
to the URL where they can authenticate 
using their chosen service.
`logout/2` as it's name suggests, handles logging out 
and redirects back to the `/items` page.xs

## 4. Modify `list_items/0` to allow ownership

Open 
`lib/app/todo.ex`
and locate the 
`list_items/0` function.
This function is called to fetch the list of items.
However, we now need to know 
**who** an `item` belongs to
in case the `person` is logged-in.

Change the `list_items/0` function 
to the following:

```elixir
def list_items(person_id \\ 0) do
  query =
    from(
      i in Item,
      select: i,
      where: i.person_id == ^person_id,
      order_by: [asc: i.id]
    )

  Repo.all(query)
end
```

## 5. Update `ItemController`

`auth_plug` adds the 
**`:loggedin`** 
(`boolean` to know if the `person` is logged in or not)
and **`person`** 
(the `map` of information about the `person` that is logged in) 
The latter is not always set. 
If no `person` is logged in, 
`:person` will not be present in `conn.assigns`.

We want this information in the view 
to conditionally render it.
For this, we need to change a few things in `ItemController`.
Open `lib/app_web/controllers/item_controller.ex`
and change `index/2` to the following:

```elixir
def index(conn, params) do
  item =
    if not is_nil(params) and Map.has_key?(params, "id") do
      Todo.get_item!(params["id"])
    else
      %Item{}
    end

  render(conn, "index.html",
    items: Todo.list_items(get_person_id(conn)),
    changeset: Todo.change_item(item),
    editing: item,
    filter: Map.get(params, "filter", "all")
  )
end

# get the person_id from conn.assigns.person.id
def get_person_id(conn) do
  case Map.has_key?(conn.assigns, :person) do
    false ->
      0

    true ->
      Map.get(conn.assigns.person, :id)
  end
end
```

This update to `index/2` is simple;
the `get_person_id/1` function is used when 
looking up the `Todo.list_items`
if the `:person` is logged in, 
and fetch their `items`.

In the `create/2` function,
change it so it looks like so.

```elixir
def create(conn, %{"item" => item_params}) do
  item_params = Map.put(item_params, "person_id", get_person_id(conn))

  case Todo.create_item(item_params) do
    {:ok, _item} ->
      conn
      |> put_flash(:info, "Item created successfully.")
      |> redirect(to: ~p"/items/")
    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, :new, changeset: changeset)
  end
end
```

We are adding `person_id` to the `Item` model
when creating a todo item.

Finally, let's fix `clear_completed/2`.
Instead of having: 

```elixir
person_id = 0
query = from(i in Item, where: i.person_id == ^person_id, where: i.status == 1)
```

Change it to the following.

```elixir
person_id = get_person_id(conn)
query = from(i in Item, where: i.person_id == ^person_id, where: i.status == 1)
```

We are only missing the last piece of the puzzle:
changing the view.
Let's do just that 😄

## Conditionally rendering in `index.html.heex`

This part is simple. 
We are going to conditionally render the page
according to whether the user is logged in or not.
We will use this.

```html
<%= if @loggedin do %>
<!-- Render list of items of user -->
<% else %>
<!-- Render logout button -->
<% end %>
```

We will also have a `login` and `logout` button.
Here's an example of the `logout` button.

```html
<.link href="/logout">
  Logout
</.link>
```

It's that simple! Just a link
that redirects to `/logout`, 
which is handled by the `AuthController` 
we created earlier.

Change the file 
so it looks like this.

[`lib/app_web/controllers/item_html/index.html.heex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/ade66afa30ac7eddb55edf3b45ba6f030d4252aa/lib/app_web/controllers/item_html/index.html.heex)

And that should be it! 🎉
However, we are not done!
We broke some tests while we implemented this feature.
Let's fix those.

## Fixing the tests

### `test/app/todo_test.exs`

Open `test/app/todo_test.exs`.
We are going to focus 
on changing the `person_id`
in the tests so it is valid
and makes sense when running the tests.

Find `"create_item/1 with valid data creates a item"`
and change it to the following.

```elixir
test "create_item/1 with valid data creates a item" do
  valid_attrs = %{person_id: 0, status: 0, text: "some text"}

  assert {:ok, %Item{} = item} = Todo.create_item(valid_attrs)
  assert item.person_id == 0
  assert item.status == 0
  assert item.text == "some text"
end
```

Find `"update_item/2 with valid data updates the item"`
and change it to the following.

```elixir
test "update_item/2 with valid data updates the item" do
  item = item_fixture()
  update_attrs = %{person_id: 1, status: 1, text: "some updated text"}

  assert {:ok, %Item{} = item} = Todo.update_item(item, update_attrs)
  assert item.person_id == 1
  assert item.status == 1
  assert item.text == "some updated text"
end
```

Find `"list_items/0 returns all items"`
and change it to the following.

```elixir
test "list_items/0 returns all items" do
  item = item_fixture()
  assert Todo.list_items(0) == [item]
end
```

### `test/support/fixtures/todo_fixtures.ex`

Most of these tests
use the `item_fixture/0` function
to create an `Item` object.
As it stands, this object is not valid.
So we need to change it.
Open `test/support/fixtures/todo_fixtures.ex`
and change the function so it looks like so.

```elixir
def item_fixture(attrs \\ %{}) do
  {:ok, item} =
    attrs
    |> Enum.into(%{
      person_id: 0,
      status: 0,
      text: "some text"
    })
    |> App.Todo.create_item()
  item
end
```

### `test/app_web/controllers/auth_controller_test.exs`

We've created an `AuthController`.
We need to test it!
Create a file in
`test/app_web/controllers/auth_controller_test.exs`
and add the following code to it.

```elixir
defmodule AppWeb.AuthControllerTest do
  use AppWeb.ConnCase, async: true

  test "Logout link displayed when loggedin", %{conn: conn} do
    data = %{
      username: "test_username",
      email: "test@email.com",
      givenName: "John Doe",
      picture: "this",
      auth_provider: "GitHub",
      sid: 1,
      id: 1
    }
    jwt = AuthPlug.Token.generate_jwt!(data)

    conn = get(conn, "/?jwt=#{jwt}")
    assert html_response(conn, 200) =~ "logout"
  end

  test "get /logout with valid JWT", %{conn: conn} do
    data = %{
      email: "al@dwyl.com",
      givenName: "Al",
      picture: "this",
      auth_provider: "GitHub",
      sid: 1,
      id: 1
    }

    jwt = AuthPlug.Token.generate_jwt!(data)

    conn =
      conn
      |> put_req_header("authorization", jwt)
      |> get("/logout")

    assert "/items" = redirected_to(conn, 302)
  end

  test "test login link redirect to authdemo.fly.dev", %{conn: conn} do
    conn = get(conn, "/login")
    assert redirected_to(conn, 302) =~ "authdemo.fly.dev"
  end
end
```

We are testing the `logout` and `login` procedures.
We check if the redirection works properly after 
the user logs in. 
Additionally, we check if the `logout` button 
is displayed after the user properly signs in.

### `test/app_web/controllers/item_controller_test.exs`

We're in the final stretch!
We just need to fix the tests
in `item_controller_test.exs`

Open the file
`test/app_web/controllers/item_controller_test.exs`
and locate the `create_item/1` private function.
Add the following code after it.

```elixir
  defp setup_conn(conn) do
   new_assigns = %{
    person: %{
      app_id: 5,
      aud: "Joken",
      auth_provider: "github",
      email: "test@email.com",
      exp: 1702132323,
      givenName: nil,
      iat: 1670595323,
      id: 1,
      iss: "Joken",
      jti: "2snib63q7a9l9sfmdg00117h",
      nbf: 1670595323,
      sid: 1,
      username: "test_username",
      picture: "this",
      givenName: "John Doe"
    },
    loggedin: true
   }

   new_assigns = Map.put(new_assigns, :jwt, AuthPlug.Token.generate_jwt!(%{
    email: "test@email.com",
    givenName: "John Doe",
    picture: "this",
    auth_provider: "GitHub",
    sid: 1,
    id: 1
   }))

   Map.replace(conn, :assigns, new_assigns)
  end
```

We will use this function to 
add test assigns to the `conn` object.
This will simulate a logged in user.

Now we just need to *use* this function
inside the needed tests.
Add the following line

```elixir
conn = setup_conn(conn)
```

to the following tests: 
- "lists all items"
- "renders form"
- "redirects to show when data is valid"
- "renders form for editing chosen item"
- "redirects when data is valid"
- "deletes chosen item"

Additionally, change`"redirects when data is valid"` test
to the following. 
We are just testing for the redirection.

```elixir
    test "redirects when data is valid", %{conn: conn, item: item} do
      conn = setup_conn(conn)
      conn = put(conn, ~p"/items/#{item}", item: @update_attrs)
      assert redirected_to(conn) == ~p"/items/"
    end
```

The file should look like this
after you've made these changes.

[`test/app_web/controllers/item_controller_test.exs `](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1b11c5f91d9327969bfa25883b3df6a7107e28f1/test/app_web/controllers/item_controller_test.exs)

If you now run the tests 
(`mix test`), 
all tests should pass.

```sh
Finished in 0.7 seconds (0.6s async, 0.09s sync)
28 tests, 0 failures
```

## And you're done! 🎉 
Congratulations, you just added authentication
to your application!
It should look like this, now.

![final_with_auth](https://user-images.githubusercontent.com/17494745/206777761-aeb76854-3578-4deb-850d-ecc3d96a1cb6.gif)

Give yourself a pat on the back 😉 !