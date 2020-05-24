<div align="center">

# Phoenix Todo List Tutorial

A complete beginners tutorial building a Todo List in Phoenix.

[![Build Status](https://img.shields.io/travis/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](https://travis-ci.org/dwyl/phoenix-todo-list-tutorial)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](http://codecov.io/github/dwyl/phoenix-todo-list-tutorial?branch=master)
<!-- [![HitCount](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial.svg)](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial) -->

</div>
<br />


## Why? 🤷‍

Todo lists are familiar to most people. <br />
_Building_ a Todo list from scratch is a great way to learn Phoenix.
This tutorial does not assume any prior Phoenix knowledge/experience.

<br />

## What? 💭

A todo list example created from scratch step-by-step in Elixir/Phoenix.

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

## _How_? 🚧


### Before You Start!

Before you attempt to _build_ the Todo List,
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
mix deps.get
cd assets && npm install && cd ..
```

Setup the database:

```sh
mix ecto.setup
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

### 3.2 Add TodoMVC CSS to Layout

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
    <link rel="stylesheet" href="https://todomvc-app.herokuapp.com/lib/todomvc-common-base.css">
    <link rel="stylesheet" href="https://todomvc-app.herokuapp.com/lib/todomvc-app.css">
  </head>
  <body>
    <main role="main" class="container">
      <%= @inner_content %>
    </main>

    <script defer type="text/javascript" src="<%= Routes.static_path(@conn, "/js/app.js") %>"></script>
  </body>
</html>
```

The important bit that has changed
is the addition of these two CSS stylesheets:

```html
<link rel="stylesheet" href="https://todomvc-app.herokuapp.com/lib/todomvc-common-base.css">
<link rel="stylesheet" href="https://todomvc-app.herokuapp.com/lib/todomvc-app.css">
```

> Before:
[`/lib/app_web/templates/layout/app.html.eex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bddacda93ecd892fe0907210bab335e6b6e5e489/lib/app_web/templates/layout/app.html.eex) <br />
> After: [`/lib/app_web/templates/layout/app.html.eex#L8-L9`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1d9198013d2db1e0e219b0b61b0173428aab0ba8/lib/app_web/templates/layout/app.html.eex#L8-L9)


With the layout template saved, your `/items` page should now look like this:

![items-with-todomvc-css](https://user-images.githubusercontent.com/194400/82726927-3049bb80-9cdf-11ea-9522-084327c05ed5.png)



> **Note**: we are loading these CSS files from a remote source.
> If you prefer to load the CSS locally for any reason,
simply download the files and add them to the `/assets/css` directory.
And import them in the `app.scss` file
e.g: [`#7bfbfd4`](https://github.com/dwyl/phoenix-todo-list-tutorial/pull/35/commits/7bfbfd4faf0e40b1d881685faa1f26af95703aee#r429529917)
We just do the direct linking of the Stylesheets to save steps.


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

### 6. Update Number of Items in UI

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
[]()

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
[]()

Now that the tests are passing,
_use_ the `remaining_items/1` in the `index.html` template.
Open the `lib/app_web/templates/item/index.html.eex` file
and locate the line of code:

```html
<span class="todo-count"><strong>1</strong> items left</span>
```

Replace it with this line:
```html
<span class="todo-count"><%= remaining_items(@items) %> items left</span>
```

This just invokes the `ItemView.remaining_items/1` function
with the List of `@items` which will return the integer count
of remaining items that have not yet been "done".

E.g:
[]()




<br />

### 7. Update a Todo Item's `status` To `1` ("Done")





### 7.x Remove Old Template from `index.html`


<br />

### 8. Footer Navigation





<br />

### 9. Clear Completed


### Done!



<br />

### Part 2: Authentication!






<br />

## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
