<div align="center">

# Phoenix Todo List Tutorial

A complete beginners tutorial building a Todo List in Phoenix.

[![Build Status](https://img.shields.io/travis/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](https://travis-ci.org/dwyl/phoenix-todo-list-tutorial)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](http://codecov.io/github/dwyl/phoenix-todo-list-tutorial?branch=master)
<!-- [![HitCount](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial.svg)](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial) -->

</div>
<br />


## Why? 🤷‍

Todo lists are familiar to most people;
we make lists all the time.
_Building_ a Todo list from scratch is a great way to learn Phoenix
because the UI/UX is simple,
so we can focus on implementation.
This tutorial shows complete beginners how to build a Todo list
in Phoenix without assuming any prior Phoenix knowledge/experience.

<br />

## What? 💭

A Todo list tutorial created from scratch step-by-step in Elixir/Phoenix.


### Try it on Heroku: [phxtodo.herokuapp.com](https://phxtodo.herokuapp.com)


### TodoMVC

We are using the
[TodoMVC](https://github.com/dwyl/javascript-todo-list-tutorial#todomvc)
CSS to make our UI look good and simplify our code.


<br />

## Who? 👤

This example/tutorial is targeted
at anyone who is learning to Elixir/Phoenix.
We have included _all_ the steps required to build the app.
If you get stuck on any step,
please open an
[issue](https://github.com/dwyl/phoenix-todo-list-tutorial/issues)
on GitHub where we can help you get unstuck!

<br />

## _How_? 👩‍💻


### Before You Start! 💡

_Before_ you attempt to _build_ the Todo List,
make sure you have everything you need installed on you computer.
See:
[prerequisites](https://github.com/dwyl/phoenix-chat-example#0-pre-requisites-before-you-start)

Once you have confirmed that you have Phoenix & PostgreSQL installed,
try running the _finished_ App.


### Run The _Finished_ App on Your `localhost` 💻

_Before_ you start building your own version of the Todo List App,
run the _finished_ version on your `localhost`
to confirm that it works.

Clone the project from GitHub:

```sh
git clone git@github.com:dwyl/phoenix-todo-list-tutorial.git && cd phoenix-todo-list-tutorial
```

Install dependencies and setup the database:

```sh
mix setup
```

Start the Phoenix server:

```sh
mix phx.server
```

Visit
[`localhost:4000`](http://localhost:4000)
in your web browser.




You should see:

# TODO: add screenshot/GIF of todo list home page


Now that you have the _finished_ example app
running on your localhost,
let's build it from scratch
and understand all the steps.



### 1. Create a New Phoenix Project 🆕

In your terminal, create a new Phoenix app using the command:

```sh
mix phx.new app
```

Ensure you install all the dependencies:

```sh
mix setup
```

Start the Phoenix server:

```sh
mix phx.server
```

Now you can visit
[`localhost:4000`](http://localhost:4000)
from your web browser.

![welcome-to-phoenix](https://user-images.githubusercontent.com/194400/82494801-11caa100-9ae2-11ea-821d-8181580201cb.png)

Shut down the Phoenix server <kbd>ctrl</kbd>+<kbd>C</kbd>.

Run the tests to ensure everything works as expected:

```sh
mix test
```

You should see:

```sh
Compiling 16 files (.ex)
Generated app app

17:49:40.111 [info]  Already up
...

Finished in 0.04 seconds
3 tests, 0 failures
```

Having established that the Phoenix App works as expected,
let's move on to creating the list!

<br />

### 2. Create `items` Schema

In creating a basic Todo List we only need one schema: `items`.
Later we can add separate lists and tags to organise/categorise
our `items` but for now this is all we need.

Run the following [generator](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html) command to create the  

```sh
mix phx.gen.html Ctx Item items text:string person_id:integer status:integer
```

Strictly speaking we only _need_ the `text` and `status` fields,
but since we know we want to associate items with people
(_later in the tutorial),
we are adding the field _now_.


You will see the following output:

```
* creating lib/app_web/controllers/item_controller.ex
* creating lib/app_web/templates/item/edit.html.eex
* creating lib/app_web/templates/item/form.html.eex
* creating lib/app_web/templates/item/index.html.eex
* creating lib/app_web/templates/item/new.html.eex
* creating lib/app_web/templates/item/show.html.eex
* creating lib/app_web/views/item_view.ex
* creating test/app_web/controllers/item_controller_test.exs
* creating lib/app/ctx/item.ex
* creating priv/repo/migrations/20200521145424_create_items.exs
* creating lib/app/ctx.ex
* injecting lib/app/ctx.ex
* creating test/app/ctx_test.exs
* injecting test/app/ctx_test.exs

Add the resource to your browser scope in lib/app_web/router.ex:

    resources "/items", ItemController


Remember to update your repository by running migrations:

    $ mix ecto.migrate
```

That created a _bunch_ of files.
Some of which we don't strictly _need_.
We could create _only_ the files we _need_,
but this is the "official" way of creating a CRUD App in Phoenix,
so we are using it for speed.
See the commit:
[40d4e8d](https://github.com/dwyl/phoenix-todo-list-tutorial/pull/35/commits/40d4e8dd98bae7c517e9a0b59bc2491f4b3c7a0f)


> **Note**: Phoenix
[Contexts](https://hexdocs.pm/phoenix/contexts.html)
denoted in this example as `Ctx`,
are "_dedicated modules that expose and group related functionality_."
We feel they _unnecessarily complicate_ basic Phoenix Apps,
with layers of "interface" and we _really_ wish we could
[avoid](https://github.com/phoenixframework/phoenix/issues/3832) them.
But given that they are baked into the generators,
and the _creator_ of the framework
[_likes_](https://youtu.be/tMO28ar0lW8?t=376) them
(_regardless of them complicating simple apps and confusing beginners_),
we have a choice: either get on board with Contexts
or _manually_ create all the files in our Phoenix projects.


<br />

### 2.1 Add the `/items` Resources to `router.ex`

Follow the instructions presented by the generator to
add the `resources "/items", ItemController` line to the `router.ex` file.

Open the `lib/app_web/router.ex` file
and locate the `scope "/", AppWeb do` section.
Add the line to the end of the block, e.g:

```elixir
scope "/", AppWeb do
  pipe_through :browser

  get "/", PageController, :index
  resources "/items", ItemController
end
```

Your `router.ex` file should look like this:
[`router.ex#L20`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/f66184b58b7dd1ef593680e7a1a446247909cae7/lib/app_web/router.ex#L20)

<br />

### 2.2 _Run_ The App!

At this point we _already_ have a functional Todo List
(_if we were willing to use the default Phoenix UI_).
Try running the app on your `localhost`:

```
mix phx.server
```

Visit: http://localhost:4000/items/new
and input some data.

![todo-list-phoenix-default-ui](https://user-images.githubusercontent.com/194400/82673112-3edd9780-9c39-11ea-84d3-f62c3e456a6b.png)

Click the "Save" button
and you will be redirected to the "show" page:
[/items/1](http://localhost:4000/items/1)

![todo-list-phoenix-default-ui-show-item](https://user-images.githubusercontent.com/194400/82674191-d7c0e280-9c3a-11ea-9c52-9a37525d0626.png)

This is not an attractive User Experience (UX),
but it _works_!
Here is a _list_ of items; a "Todo List":

![todo-list-phoenix-default-ui-show-items-list](https://user-images.githubusercontent.com/194400/82674676-967d0280-9c3b-11ea-999f-bf5fbe1ab2d4.png)


Let's improve the UX by using the TodoMVC CSS!

<br />

### 3. Create the TodoMVC UI/UX

To recreate the TodoMVC UI/UX,
let's borrow the code directly from the example.



Visit: http://todomvc.com/examples/vanillajs
and inspect the source.
e.g:

![todomvc-view-source](https://user-images.githubusercontent.com/194400/82698634-0b176780-9c63-11ea-9e1d-7aa6e2328766.png)

Right-click on the source you want and select "Edit as HTML":

![edit-as-html](https://user-images.githubusercontent.com/194400/82721624-b8679b00-9cb6-11ea-8d3f-2405f2bd301f.png)


Once the `HTML` for the `<section>` is editable,
select it and copy it.

![todomvc-html-editable-copy](https://user-images.githubusercontent.com/194400/82721711-b05c2b00-9cb7-11ea-85c2-083d2981440d.png)


The `HTML` code is:


```html
<section class="todoapp">
  <header class="header">
  	<h1>todos</h1>
  	<input class="new-todo" placeholder="What needs to be done?" autofocus="">
  </header>
  <section class="main" style="display: block;">
  	<input id="toggle-all" class="toggle-all" type="checkbox">
  	<label for="toggle-all">Mark all as complete</label>
  	<ul class="todo-list">
      <li data-id="1590167947253" class="">
        <div class="view">
          <input class="toggle" type="checkbox">
          <label>Learn how to build a Todo list in Phoenix</label>
          <button class="destroy"></button>
        </div>
      </li>
      <li data-id="1590167956628" class="completed">
        <div class="view">
          <input class="toggle" type="checkbox">
          <label>Completed item</label>
          <button class="destroy"></button>
        </div>
      </li>
    </ul>
  </section>
  <footer class="footer" style="display: block;">
  	<span class="todo-count"><strong>1</strong> item left</span>
  	<ul class="filters">
  		<li>
  			<a href="#/" class="selected">All</a>
  		</li>
  		<li>
  			<a href="#/active">Active</a>
  		</li>
  		<li>
  			<a href="#/completed">Completed</a>
  		</li>
  	</ul>
  	<button class="clear-completed" style="display: block;">Clear completed</button>
  </footer>
</section>
```

Let's convert this `HTML` to an Embedded Elixir
([`EEx`](https://hexdocs.pm/eex/EEx.html)) template.


> **Note**: the _reason_ that we are copying this `HTML`
from the browser inspector instead of _directly_ from the source
on GitHub:
[`examples/vanillajs/index.html`](https://github.com/tastejs/todomvc/blob/c50cc922495fd76cb44844e3b1cd77e35a5d6be1/examples/vanillajs/index.html#L18)
is that this is a "single page app",
so the `<ul class="todo-list"></ul>`
only gets populated in the browser.
So copying it from the browser Dev Tools
is the easiest way to get the _complete_ `HTML`.



### 3.1 Paste the HTML into `index.html.eex`

Open the `lib/app_web/templates/item/index.html.eex` file
and scroll to the bottom.

Then (_without removing the code that is already there_)
paste the `HTML` code we sourced from TodoMVC.

> e.g:
[`/lib/app_web/templates/item/index.html.eex#L33-L73`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bddacda93ecd892fe0907210bab335e6b6e5e489/lib/app_web/templates/item/index.html.eex#L33-L73)

If you attempt to run the app now
and visit
[http://localhost:4000/items/](http://localhost:4000/items/)
You will see this (without the TodoMVC CSS):

![before-adding-css](https://user-images.githubusercontent.com/194400/82725401-af85c200-9cd4-11ea-8717-714477fc3157.png)

That's obviously not what we want, so let's add the TodoMVC CSS!

### 3.2 Add Simplify Layout Template

Open your `lib/app_web/templates/layout/app.html.eex` file
and replace the contents with the following code:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Phoenix Todo List</title>
    <link rel="stylesheet" href="<%= Routes.static_path(@conn, "/css/app.css") %>"/>
        <script defer type="text/javascript" src="<%= Routes.static_path(@conn, "/js/app.js") %>"></script>
  </head>
  <body>
    <main role="main" class="container">
      <%= @inner_content %>
    </main>
  </body>
</html>
```


> Before:
[`/lib/app_web/templates/layout/app.html.eex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bddacda93ecd892fe0907210bab335e6b6e5e489/lib/app_web/templates/layout/app.html.eex) <br />
> After:
[`/lib/app_web/templates/layout/app.html.eex#L8-L15`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/65bec23b92307527a414f77b667b29ea10619e5a/lib/app_web/templates/layout/app.html.eex#L8-L15)

### 3.3 Save the TodoMVC CSS to `/assets/css`

Visit
http://todomvc.com/examples/vanillajs/node_modules/todomvc-app-css/index.css
and save the file to `/assets/css/todomvc-app.css`.

e.g:
[`/assets/css/todomvc-app.css`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/65bec23b92307527a414f77b667b29ea10619e5a/assets/css/todomvc-app.css)

### 3.4 Import the `todomvc-app.css` in

Open the `assets/css/app.scss` file and replace it with the following:

```css
/* This file is for your main application css. */
/* @import "./phoenix.css"; */
@import "./todomvc-app.css";
```

e.g:
[`/assets/css/app.scss#L3`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/5fd673089be616c9bb783277ae2d4f0e310b8413/assets/css/app.scss#L3)

With the layout template saved,
the TodoMVC CSS file saved to `/asssets/css/todomvc-app.css`
and the `todomvc-app.css` imported in `app.scss`,
your `/items` page should now look like this:

![items-with-todomvc-css](https://user-images.githubusercontent.com/194400/82726927-3049bb80-9cdf-11ea-9522-084327c05ed5.png)


So our Todo List is starting to look like TodoMVC,
but it's still just a dummy list.

<br />

### 4. Render _Real_ Data in the TodoMVC Layout

We are going to need a handful of
[View functions](https://hexdocs.pm/phoenix/views.html)
in order to render our `item` data in the TodoMVC template.
Let's create the first two which are fairly basic.

This is our first chance to do a bit of Test Driven Development (TDD),
Create a new file with the path `test/app_web/views/item_view_test.exs`.

Paste (_or type_) the following code into the file:

```elixir
defmodule AppWeb.ItemViewTest do
  use AppWeb.ConnCase, async: true
  alias AppWeb.ItemView

  test "complete/1 returns completed if item.status == 1" do
    assert ItemView.complete(%{status: 1}) == "completed"
  end

  test "complete/1 returns empty string if item.status == 0" do
    assert ItemView.complete(%{status: 0}) == ""
  end

  test "checked/1 returns checked if item.status == 1" do
    assert ItemView.checked(%{status: 1}) == "checked"
  end

  test "checked/1 returns empty string if item.status == 0" do
    assert ItemView.checked(%{status: 0}) == ""
  end
end
```

e.g:
[`/test/app_web/views/item_view_test.exs`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/031df4076fc4ff84fd719a3a66c6dd2495268a50/test/app_web/views/item_view_test.exs)


If you attempt to run this test file:

```sh
mix test test/app_web/views/item_view_test.exs
```

You will see the following error (because the function does not yet exist!):

```
== Compilation error in file lib/app_web/views/item_view.ex ==
** (CompileError) lib/app_web/templates/item/index.html.eex:44: undefined function complete/1
```

Open the
`lib/app_web/views/item_view.ex` file
and write the functions to make the tests pass.

<br />

This is how we implemented the functions.

```elixir
# add class "completed" to a list item if item.status=1
def complete(item) do
  case item.status do
    1 -> "completed"
    _ -> "" # empty string means empty class so no style applied
  end
end

# add "checked" to input if item.status=1
def checked(item) do
  case item.status do
    1 -> "checked"
    _ -> "" # empty string means empty class so no style applied
  end
end
```

e.g:
[`/lib/app_web/views/item_view.ex#L4-L18`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/0d55a4ea0d5f58a364a23070da52ddfe0f9d55ea/lib/app_web/views/item_view.ex#L4-L18)

Re-run the tests and they should now pass:

```sh
mix test test/app_web/views/item_view_test.exs
```

You should see:

```sh
....

Finished in 0.1 seconds
4 tests, 0 failures
```


Now that we have created these two view functions,
and our tests are passing,
let's _use_ them in our template!

Open the `lib/app_web/templates/item/index.html.eex` file
and locate the line:

```html
<ul class="todo-list">
```

Replace the _contents_ of the `<ul>` with the following:

```html
<%= for item <- @items do %>
  <li data-id="<%= item.id %>" class="<%= complete(item) %>">
    <div class="view">
      <input <%= checked(item) %> class="toggle" type="checkbox">
      <label><%= item.text %></label>
      <%= link "", class: "destroy",
        to: Routes.item_path(@conn, :delete, item), method: :delete,
        data: [confirm: "Are you sure?"] %>
    </div>
  </li>
<% end %>
```

e.g:
[`/lib/app_web/templates/item/index.html.eex#L43-L53`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1fbea19f0b2b74baa4c88ad1518bf2291507b499/lib/app_web/templates/item/index.html.eex#L41-L55)


With those two files saved,
if you run the app now: `mix phx.server`
and visit [`/items`](http://localhost:4000/items)
You will see the _real_ `items` you created in step 2.2 (above):

![todo-list-real-items](https://user-images.githubusercontent.com/194400/82729253-f46a2280-9ced-11ea-940f-75d6ff4c4ece.png)


Now that we have our items rendering in the TodoMVC layout,
let's work on creating new items in the "single page app" style.

<br />

### 5. In-line the New Item Creation Form

At present our "New Item" form is available at:
http://localhost:4000/items/new
(_as noted in step 2 above_)

We want the person to be able to create a new item
without having to navigate to a different page.
In order to achieve that goal,
we will include the `form.html` template (_partial_)
inside the `index.html` template. e.g:

```elixir
<%= render "form.html", Map.put(assigns, :action, Routes.item_path(@conn, :create)) %>
```

Before we can do that, we need to tidy up the `form.html`
template to remove the fields we don't _need_.

Let's open `lib/app_web/templates/item/form.html.eex`
and simplify it to just the essential field `:text`:

```elixir
<%= form_for @changeset, @action, fn f -> %>
  <%= text_input f, :text, placeholder: "what needs to be done?",
    class: "new-todo", autofocus: "" %>
  <div style="display: none;"> <%= submit "Save" %> </div>
<% end %>
```

> Before:
[`/lib/app_web/templates/item/form.html.eex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/cc287975eef5ca8b738f49723fe8a03d9da52a19/lib/app_web/templates/item/form.html.eex) <br />
> After:
[`/lib/app_web/templates/item/form.html.eex#L2-L3`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/50a6f9ab9e2cb7d9ed3023fc64590992a2ee73af/lib/app_web/templates/item/form.html.eex#L2-L3)


If you run the Phoenix App now and visit
[http://localhost:4000/items/new](http://localhost:4000/items/new)
you will see the _single_ `:text` input field and no "Save" button:

![new-item-single-text-field-no-save-button](https://user-images.githubusercontent.com/194400/82753057-a7a04d80-9dba-11ea-9a08-3d904702e1e8.png)

Don't worry, you can still submit the form with <kbd>Enter</kbd> (Return) key.
However if you attempt to submit the form now,
it won't work because we removed two of the fields required by the `changeset`!
Let's fix that.


### 5.1 Update the `items` Schema to Set `default` Values

Given that we have removed two of the fields (`:person_id` and `:status`)
from the `form.html.eex`,
we need to ensure there are default values for these in
the schema.
Open the `lib/app/ctx/item.ex` file
and replace the contents with the following:

```elixir
defmodule App.Ctx.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :person_id, :integer, default: 0
    field :status, :integer, default: 0
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :person_id, :status])
    |> validate_required([:text])
  end
end
```

Here we are updating the "items" `schema`
to set a default value of `0`
for both `person_id` and `status`.
And in the `changeset/2` we are removing the _requirement_
for `person_id` and `status`.
That way our new `item` form
can be submitted with _just_ the `text` field.


Before:
[`/lib/app/ctx/item.ex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/031df4076fc4ff84fd719a3a66c6dd2495268a50/lib/app/ctx/item.ex) <br />
After:
[`/lib/app/ctx/item.ex#L6-L7`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/cc287975eef5ca8b738f49723fe8a03d9da52a19/lib/app/ctx/item.ex#L6-L7)


Now that we have `default` values for `person_id` and `status`
if you submit the `/items/new` form it will succeed.



### 5.2 Update `index/2` in `ItemController`

In order to in-line the new item form (`form.html.eex`)
in the `index.html.eex` template,
we need to update the `AppWeb.ItemController.inded/2`
to include a Changeset.

Open the `lib/app_web/controllers/item_controller.ex` file
and update the `index/2` function to the following:

```elixir
def index(conn, _params) do
  items = Ctx.list_items()
  changeset = Ctx.change_item(%Item{})
  render(conn, "index.html", items: items, changeset: changeset)
end
```

Before:
[`/lib/app_web/controllers/item_controller.ex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/031df4076fc4ff84fd719a3a66c6dd2495268a50/lib/app_web/controllers/item_controller.ex) <br />
After:
[`/lib/app_web/controllers/item_controller.ex#L9-L10`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/aed0b2c037ea0cdf5461b2287fc4b63d61cd7b14/lib/app_web/controllers/item_controller.ex#L9-L10)


You will not _see_ any change in the UI or tests after this step.
Just move on to 5.3 where the "aha" moment happens.


### 5.3 Render The `form.html.eex` inside `index.html.eex`

Now that we have done all the preparation work,
the next step is to render the `form.html.eex` (_partial_)
inside `index.html.eex` template.

Open the `lib/app_web/templates/item/index.html.eex` file
and locate the line:

```html
<input class="new-todo" placeholder="What needs to be done?" autofocus="">
```

Replace it with this:

```elixir
<%= render "form.html", Map.put(assigns, :action, Routes.item_path(@conn, :create)) %>
```

Before:
[`/lib/app_web/templates/item/index.html.eex#L36`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/031df4076fc4ff84fd719a3a66c6dd2495268a50/lib/app_web/templates/item/index.html.eex#L36) <br />
After:
[`/lib/app_web/templates/item/index.html.eex#L36`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/41ad6d445e6d9b8cc85cccbee5ed64adcdad0eef/lib/app_web/templates/item/index.html.eex#L36)



If you run the app now and visit:
[http://localhost:4000/items](http://localhost:4000/items)
You can create an item by typing your text
and submit it with the <kbd>Enter</kbd> (Return) key.

<div align="center">

![todo-list-tutorial-step-5](https://user-images.githubusercontent.com/194400/82753376-f4852380-9dbc-11ea-9003-2015ffee79f5.gif)

</div>

Redirecting to the "show" template
is "OK", but we can do better UX by
redirecting to back to the `index.html` template.
Thankfully this is as easy as updating a single line in the code.

### 5.4 Update the `redirect` in `create/2`

Open the `lib/app_web/controllers/item_controller.ex` file
and locate the `create` function.
_Specifically_ the line:

```elixir
|> redirect(to: Routes.item_path(conn, :show, item))
```

Update the line to:

```elixir
|> redirect(to: Routes.item_path(conn, :index))
```

Before:
[`/lib/app_web/controllers/item_controller.ex#L22`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/031df4076fc4ff84fd719a3a66c6dd2495268a50/lib/app_web/controllers/item_controller.ex#L22) <br />
After:
[`/lib/app_web/controllers/item_controller.ex#L23`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/69226e331ca7909d6e74b245a1ae066f22ebab38/lib/app_web/controllers/item_controller.ex#L23)

Now when we create a new `item`
we are redirected to the `index.html` template:

<div align="center">

![todo-list-tutorial-redirect-to-index](https://user-images.githubusercontent.com/194400/82753765-23e95f80-9dc0-11ea-87b5-a33692a3f374.gif)

</div>

### 5.5 Update `item_controller_test.exs` to Redirect to `index`

The change we just made in Step 5.4 (_above_) works in the UI,
but it breaks one of our automated tests.

Run the tests:

```sh
mix test
```

You will see the following output:

```
13:46:49.861 [info]  Already up
.........

  1) test create item redirects to show when data is valid (AppWeb.ItemControllerTest)
     test/app_web/controllers/item_controller_test.exs:30
     match (=) failed
     code:  assert %{id: id} = redirected_params(conn)
     left:  %{id: id}
     right: %{}
     stacktrace:
       test/app_web/controllers/item_controller_test.exs:33: (test)

.............

Finished in 0.4 seconds
23 tests, 1 failure
```

Open the `test/app_web/controllers/item_controller_test.exs` file and
scroll to the line of the failing test.

Replace the test:
```elixir
test "redirects to show when data is valid", %{conn: conn} do
  conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)

  assert %{id: id} = redirected_params(conn)
  assert redirected_to(conn) == Routes.item_path(conn, :show, id)

  conn = get(conn, Routes.item_path(conn, :show, id))
  assert html_response(conn, 200) =~ "Show Item"
end
```

With this updated test:

```elixir
test "redirects to :index page when item data is valid", %{conn: conn} do
  conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)

  assert redirected_to(conn) == Routes.item_path(conn, :index)
  assert html_response(conn, 302) =~ "redirected"

  conn = get(conn, Routes.item_path(conn, :index))
  assert html_response(conn, 200) =~ @create_attrs.text
end
```

> Updated code:
[`/test/app_web/controllers/item_controller_test.exs#L30-L38`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/7a54bcff9b635c533dfea19f28cf364e944aeece/test/app_web/controllers/item_controller_test.exs#L30-L38)

If you re-run the tests `mix test` the will now all pass again.

```sh
13:53:59.714 [info]  Already up
.......................

Finished in 0.5 seconds
23 tests, 0 failures

```

<br />

### 6. Display Count of Items in UI

So far the main functionality of the TodoMVC UI is working,
we can create new items and they appear in our list.
In this step we are going to enhance the UI to include
the count of remaining items in the bottom left corner.

Open the `test/app_web/views/item_view_test.exs` file
and create the following two tests:

```elixir
test "remaining_items/1 returns count of items where item.status==0" do
  items = [
    %{text: "one", status: 0},
    %{text: "two", status: 0},
    %{text: "done", status: 1}
  ]
  assert ItemView.remaining_items(items) == 2
end

test "remaining_items/1 returns 0 (zero) when no items are status==0" do
  items = [
    %{text: "one", status: 1},
    %{text: "two", status: 1},
    %{text: "done", status: 1}
  ]
  assert ItemView.remaining_items(items) == 0
end
```

e.g:
[`/test/app_web/views/item_view_test.exs#L22-L38`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/f55292e2074ee4f1d4ad0e363ab9b991373a4bc6/test/app_web/views/item_view_test.exs#L22-L38)

These tests will fail because the `ItemView.remaining_items/1`
function does not exist.

Make the tests _pass_ by adding the following code to
the `lib/app_web/views/item_view.ex` file:

```elixir
# returns integer value of items where item.status == 0 (not "done")
def remaining_items(items) do
  Enum.filter(items, fn i -> i.status == 0 end) |> Enum.count
end
```

e.g:
[`/lib/app_web/views/item_view.ex#L20-L23`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/f55292e2074ee4f1d4ad0e363ab9b991373a4bc6/lib/app_web/views/item_view.ex#L20-L23)

Now that the tests are passing,
_use_ the `remaining_items/1` in the `index.html` template.
Open the `lib/app_web/templates/item/index.html.eex` file
and locate the line of code:

```html
<span class="todo-count"><strong>1</strong> item left</span>
```

Replace it with this line:
```html
<span class="todo-count"><%= remaining_items(@items) %> items left</span>
```

This just invokes the `ItemView.remaining_items/1` function
with the List of `@items` which will return the integer count
of remaining items that have not yet been "done".

E.g:
[`/lib/app_web/templates/item/index.html.eex#L58`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8b9ce7c99b06d58f8d11e59f77c32bb687edd812/lib/app_web/templates/item/index.html.eex#L58)


At this point the (remaining) items counter
in the bottom left of the TodoMVC UI is working.
Add an (unfinished) item to your list and watch the count increase to 2:

![item-count-increases-to-2](https://user-images.githubusercontent.com/194400/82764853-fd501680-9e09-11ea-980e-d3bac18c8a33.gif)




<br />

### 7. Toggle a Todo Item's `status` to `1`

One of the core functions of a Todo List is
toggling the `status` of an `item` from `0` to `1` ("complete").
Our `toggle` function also needs to
In our schema a completed `item`
has the `status` of `1`.

> Grab yourself a fresh glass of water,
this section is the most advanced one.


### 7.1 Create the Controller Tests

We are going to need two functions in our controller:
1. `toggle_status/1` toggles the status of an item
e.g: 0 to 1 and 1 to 0.
2. `toggle/2` the handler function for HTTP requests
to toggle the status of an item.

Open the `test/app_web/controllers/item_controller_test.exs` file
and append the following code to the end:

```elixir
describe "toggle updates the status of an item 0 > 1 | 1 > 0" do
  setup [:create_item]

  test "toggle_status/1 item.status 1 > 0", %{item: item} do
    assert item.status == 0
    # first toggle
    toggled_item = %{item | status: AppWeb.ItemController.toggle_status(item)}
    assert toggled_item.status == 1
    # second toggle sets status back to 0
    assert AppWeb.ItemController.toggle_status(toggled_item) == 0
  end

  test "toggle/2 updates an item.status 0 > 1", %{conn: conn, item: item} do
    assert item.status == 0
    get(conn, Routes.item_path(conn, :toggle, item.id))
    toggled_item = Ctx.get_item!(item.id)
    assert toggled_item.status == 1
  end
end
```

e.g:
[`/test/app_web/controllers/item_controller_test.exs#L84-L102`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/f5fbc8a642178f3a7633313481753f5f50cee93f/test/app_web/controllers/item_controller_test.exs#L84-L102)

<br />

### 7.2 Create the Functions to Make Tests Pass

Open the
`lib/app_web/controllers/item_controller.ex`
file and add the following functions to it:

```elixir
def toggle_status(item) do
  case item.status do
    1 -> 0
    0 -> 1
  end
end

def toggle(conn, %{"id" => id}) do
  item = Ctx.get_item!(id)
  Ctx.update_item(item, %{status: toggle_status(item)})
  redirect(conn, to: Routes.item_path(conn, :index))
end
```

e.g:
[`/lib/app_web/controllers/item_controller.ex#L64-L75`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/dff006256b43b92a335472726fe43d464e23621d/lib/app_web/controllers/item_controller.ex#L64-L75)

The tests will still _fail_ at this point because
the route we are invoking in our test does not yet exist.
Let's fix that.

<br />

### 7.3 Create `get /items/toggle/:id` Route that Invokes `toggle/2`

Open the `lib/app_web/router.ex`
and locate the line `resources "/items", ItemController`.
Add a new line:

```elixir
get "/items/toggle/:id", ItemController, :toggle
```

e.g:
[`/lib/app_web/router.ex#L21`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/ada48cbf9718b155fe40ed76b0fb98cae203e783/lib/app_web/router.ex#L21)

Now our tests will _finally_ pass:

```sh
mix test
```

You should see:
```sh
22:39:42.231 [info]  Already up
...........................

Finished in 0.5 seconds
27 tests, 0 failures
```


<br />

### 7.4 Invoke the `toggle/2` When a Checkbox is clicked in `index.html`

Now that our tests are passing,
it's time actually _use_ all this functionality we have been building
in the UI.
Open the `/lib/app_web/templates/item/index.html.eex` file
and locate the line:

```html
<input <%= checked(item) %> class="toggle" type="checkbox">
```

Replace it with the following:

```html
<a href="<%= Routes.item_path(@conn, :toggle, item.id) %>"
  class="toggle <%= checked(item) %>"></a>
```

When this link is clicked/tapped
the `get /items/toggle/:id` endpoint is invoked,
which in turn triggers the `toggle/2` handler
we defined above.


> Before:
[`/lib/app_web/templates/item/index.html.eex#L46`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a31bbe30ce593a4aa3e4fd96ac233a36d4b494b4/lib/app_web/templates/item/index.html.eex#L46) <br />
> After:
[`/lib/app_web/templates/item/index.html.eex#L46-L48`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/e76ab862ff2363c0dd293414f4ee0a3cb37c8d76/lib/app_web/templates/item/index.html.eex#L46-L48)



### 7.5 Add a `.checked` CSS to `app.scss`


Unfortunately, `<a>` tags cannot have a `:checked` pseudo selector,
so the default TodoMVC styles that worked on the `<input>` tag
will not work for the link.
So we need to add a couple of lines of CSS to our `app.scss`.
Open the `assets/css/app.scss` file and add the following lines to it:

```css
.todo-list li .checked + label {
	background-image: url('data:image/svg+xml;utf8,%3Csvg%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%20width%3D%2240%22%20height%3D%2240%22%20viewBox%3D%22-10%20-18%20100%20135%22%3E%3Ccircle%20cx%3D%2250%22%20cy%3D%2250%22%20r%3D%2250%22%20fill%3D%22none%22%20stroke%3D%22%23bddad5%22%20stroke-width%3D%223%22/%3E%3Cpath%20fill%3D%22%235dc2af%22%20d%3D%22M72%2025L42%2071%2027%2056l-4%204%2020%2020%2034-52z%22/%3E%3C/svg%3E');
	background-repeat: no-repeat;
}
```

After saving the file you should have:
[`/assets/css/app.scss#L5-L8`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/f1d76ef42ba80e209d8af4675216aaa7c73aa319/assets/css/app.scss#L5-L8)

And when you view the app,
the Toggle functionality is working as expected:

![todo-app-toggle](https://user-images.githubusercontent.com/194400/82806639-1c888b80-9e7e-11ea-8053-8dd6a770a923.gif)


**Implementation Note**: we are very deliberately
_not_ using an `JavaScript` in this tutorial
because we are demonstrating how to do a 100% server-side rendered App.
This _always_ works even when `JS` is disabled in the browser
or the device is super old and does not have a modern we browser.
We could easily have added an `onclick` attribute to the `<input>` tag,
e.g:

```html
<input <%= checked(item) %> type="checkbox" class="toggle"
onclick="location.href='
  <%= Routes.item_path(@conn, :toggle, item.id) %>';">
```

But `onclick` is `JavaScript` and we don't _need_ to resort to `JS`.
The `<a>` (link) is a perfectly semantic non-js approach to toggling
`item.status`.


<br />

### 8. _Edit_ an Item!

The final piece of _functionality_ we need to add to our UI
is the ability to _edit_ an item's text.

### 8.1 Double-Click Item Text to Edit

In the TodoMVC spec this is achieved
by creating an event listener for the double-click event
and replacing the `<label>` element with an `<input>`.
We are trying to _avoid_ using `JavaScript`
in our server-side rendered Phoenix App (_for now_),
so we want to use an alternative approach.
Thankfully we can simulate the double-click event in CSS.
https://css-tricks.com/double-click-in-css
(_we recommend reading that post and the Demo
  to fully understand how this CSS works_!)

> **Note**: the CSS implementation is not a true double-click,
a more accurate description would be "two click"
because the two clicks can occur with an arbitrary delay.
i.e. first click followed by 10sec wait and second click
will have the same effect as two clicks in quick succession.
If you want to impliment true double-click,
see:
[github.com/dwyl/javascript-todo-list-tutorial#52-double-click-item-label-to-edit](https://github.com/dwyl/javascript-todo-list-tutorial/tree/e6736add9df1f46035f8a9d1dbdc14c71a7cdb41#52-double-click-item-label-to-edit)

The reason we want to have two clicks to edit an item,
is so that people don't accidentally click/tap an item when scrolling.
So they have to deliberately click _twice_ in order to edit.





### 8.X Remove Old Template from `index.html`

Now that we have the `toggle` feature working,
we can finally remove the default Phoenix (table) layout
from the `index.html.eex` template.




<br />

### 9. Footer Navigation





<br />

### 10. Clear Completed


### 11. Tidy Up!



### Done!



<br />

### Part 2: Authentication!






<br />

## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
