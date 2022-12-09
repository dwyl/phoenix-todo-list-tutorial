# Adding authentication

If you're reading this, 
it's probably because you are interested
in adding authentication to this app.

Don't worry, we got you covered ;)

## Making schema changes

Before anything else,
we now need to change the `list_items/0` function
in `lib/app/todo.ex`.
This function is called to fetch the list of items.
However, we now need to know 
**whose user's items we need to fetch**,
in case he's logged in.

Change the function so it looks like the following.

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


## Install `auth_plug`

To make authentication integration easy,
we are going to make use of the
[`auth_plug`](https://github.com/dwyl/auth_plug)
library.
It will allow for users to sign-in using common providers
like Google or Github.

Open `mix.exs` and locate the `deps` section.
Add the following line.

```elixir
{:auth_plug, "~> 1.5"}
```

After installing, 
we are going to need an `AUTH_API_KEY`.
To get this key, please follow 
the official instructions -> 
https://github.com/dwyl/auth_plug#2-get-your-auth_api_key-

With this key, run the following command on your terminal,
where `XXXXXXX` is the key you created.

```sh
export AUTH_API_KEY=XXXXXXX
```

This will run `AUTH_API_KEY` as an env variable 
*inside the terminal session*. If you close it,
you need to run it again so it is set up.

You can run `mix phx.server` if you want to,
the app should look the same as before.

Now, in the `lib/app_web/router.ex`,
add the following lines.

```elixir
  pipeline :authOptional, do: plug(AuthPlugOptional)

  scope "/", AppWeb do
    pipe_through [:browser, :authOptional]

    get "/", ItemController, :index
    
    # Add these two lines
    get "/login", AuthController, :login
    get "/logout", AuthController, :logout

    ...
  end
```

We just created a pipeline that will run
as **middleware**.
We additionally added two endpoints, 
one for login and another to logout.
They are managed by `AuthController`, 
which we will create now.


Create the file `lib/app_web/controllers/auth_controller.ex`
and add the following lines of code.

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

When the user logs in, he is redirected
to the URL where the user can sign in using his preferred provider.
On the other hand, the `logout` function handles whenever
the user accesses `/logout` in our application. 
It logs out the user and redirects him to the index page (`/`).

## Refactoring `ItemController`

`Auth_plug` adds to assigns to the connection:
**`:loggedin`** (which says if a user is logged in or not)
and **`person`** (which holds information about the user that is logged in).
The latter is not always set. If no user is logged in, `:person` doesn't exist.

We want this information in the view to conditionally render it.
For this, we need to change a few things in `ItemController`.
Open `lib/app_web/controllers/item_controller.ex`
and change `index/2` to the following.

```elixir
  def index(conn, params) do
    item = if not is_nil(params) and Map.has_key?(params, "id") do
      Todo.get_item!(params["id"])
    else
      %Item{}
    end

    case Map.has_key?(conn.assigns, :person) do
      false ->
        items = Todo.list_items()
        changeset = Todo.change_item(item)

        render(conn, "index.html",
          items: items,
          changeset: changeset,
          editing: item,
          loggedin: Map.get(conn.assigns, :loggedin),
          filter: Map.get(params, "filter", "all")
        )

      true ->
        person_id = Map.get(conn.assigns.person, :id)

        items = Todo.list_items(person_id)
        changeset = Todo.change_item(item)

        render(conn, "index.html",
          items: items,
          changeset: changeset,
          editing: item,
          loggedin: Map.get(conn.assigns, :loggedin),
          person: Map.get(conn.assigns, :person),
          filter: Map.get(params, "filter", "all")
        )
      end
  end
```

What we just did is simple. 
We are adding `:loggedin` to the `conn` assigns.
If `:person` exists, we also add it.
If a user is logged in, 
we get the e-mail of the user 
and fetch all the user's items.

In the `create/2` function,
change it so it looks like so.

```elixir
  def create(conn, %{"item" => item_params}) do
    item_params = case Map.has_key?(conn.assigns, :person) do
      false -> item_params
      true -> Map.put(item_params, "person_id", conn.assigns.person.id)
    end

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
    person_id = case Map.has_key?(conn.assigns, :person) do
      false -> 0
      true -> Map.get(conn.assigns.person, :id)
    end
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
     <.link
        href="/logout"
      >
        Logout
      </.link>
```

It's that simple! It's just a link
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