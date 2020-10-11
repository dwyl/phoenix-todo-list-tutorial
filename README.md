<div align="center">

# Phoenix Todo List Tutorial

A complete beginners step-by-step tutorial
for building a Todo List in Phoenix.<br/>
100% functional. 0% JavaScript. Just `HTML`, `CSS` and `Elixir`.
Fast and maintainable.

[![Build Status](https://img.shields.io/travis/com/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](https://travis-ci.com/github/dwyl/phoenix-todo-list-tutorial)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](http://codecov.io/github/dwyl/phoenix-todo-list-tutorial?branch=master)
[![HitCount](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial.svg)](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/phoenix-todo-list-tutorial/issues)

</div>
<br />


## Why? 🤷‍

Todo lists are familiar to most people;
we make lists all the time.
_Building_ a Todo list from scratch is a great way to learn Elixir/Phoenix
because the UI/UX is simple,
so we can focus on implementation.

For the team
[**`@dwyl`**](https://github.com/dwyl)
this app/tutorial
is a showcase of how server side rendering
(_with client side progressive enhancement_)
can provide a excellent balance between
developer effectiveness (_shipping features fast_),
UX and _accessibility_.
The server rendered pages take less than 5ms to respond
so the UX is _fast_.
On Heroku (_after the "Free" App wakes up!_),
round-trip response times are sub 100ms for all interactions,
so it _feels_ like a client-side rendered App.


<br />

## What? 💭

A Todo list tutorial  
that shows a complete beginner
how to build an app in Elixir/Phoenix
from scratch.


### Try it on Heroku: [phxtodo.herokuapp.com](https://phxtodo.herokuapp.com)

<!-- wake heroku app before visit. see: https://github.com/dwyl/ping -->
![wake-sleeping-heroku-app](https://phxtodo.herokuapp.com/ping)


Try the Heroku version.
Add a few items to the list and test the functionality.

![todo-app-heroku-version](https://user-images.githubusercontent.com/194400/83279718-6e5a4a00-a1cd-11ea-90b3-f0b29a898b3d.gif)

Even with a full HTTP round-trip for each interaction,
the response time is _fast_.
Pay attention to how Chrome|Firefox|Safari
waits for the response from the server before re-rendering the page.
The old full page refresh of yesteryear is _gone_.
Modern browsers intelligently render just the changes!
So the UX approximates "native"!
Seriously, try the Heroku app on your Phone and see!


### TodoMVC

In this tutorial
we are using the
[TodoMVC](https://github.com/dwyl/javascript-todo-list-tutorial#todomvc)
CSS to simplify our UI.
This has several advantages
the biggest being _minimising_ how much CSS we have to write!
It also means we have a guide to which _features_
need to be implemented to achieve full functionality.

> **Note**: we _love_ `CSS` for its incredible power/flexibility,
but we know that not everyone like it.
see: [learn-tachyons#why](https://github.com/dwyl/learn-tachyons#why)
The _last_ thing we want is to waste tons of time
with `CSS` in a `Phoenix` tutorial!


<br />

## Who? 👤

This tutorial is for
anyone who is learning to Elixir/Phoenix.
No prior experience with Phoenix is assumed/expected.
We have included _all_ the steps required to build the app.

> If you get stuck on any step,
please open an
[issue](https://github.com/dwyl/phoenix-todo-list-tutorial/issues)
on GitHub where we are happy to help  you get unstuck!
If you feel that any line of code can use a bit more explanation/clarity,
please don't hesitate to _inform_ us!
We _know_ what it's like to be a beginner,
it can be _frustrating_ when something does not make sense!
If you're stuck, don't suffer in silence,
asking questions on GitHub
helps _everyone_ to learn!


<br />

## _How_? 👩‍💻


### Before You Start! 💡

_Before_ you attempt to _build_ the Todo List,
make sure you have everything you need installed on you computer.
See:
[prerequisites](https://github.com/dwyl/phoenix-chat-example#0-pre-requisites-before-you-start)

Once you have confirmed that you have Phoenix & PostgreSQL installed,
try running the _finished_ App.


### 0. Run The _Finished_ App on Your `localhost` 💻

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

![phoenix-todo-list-on-localhost](https://user-images.githubusercontent.com/194400/83285190-bed5a580-a1d5-11ea-9154-80684cf9cc0e.gif)

Now that you have the _finished_ example app
running on your `localhost`, <br />
let's build it from scratch
and understand all the steps.

If you ran the finished app on your `localhost`
(_and you really should!_), <br />
you will need to change up a directory before starting the tutorial:

```
cd ..
```

Now you are ready to _build_!

<br />

### 1. Create a New Phoenix Project 🆕

In your terminal,
create a new Phoenix app
using the following
[`mix`](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
command:

```sh
mix phx.new app
```

When prompted to install dependencies,
type <kbd>Y</kbd> followed by <kbd>Enter</kbd>.

Change into the newly created `app` directory (`cd app`)
and
ensure you have everything you need:

```sh
mix setup
```

Start the Phoenix server:

```sh
mix phx.server
```

Now you can visit
[`localhost:4000`](http://localhost:4000)
in your web browser.
You should see something similar to:

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
let's move on to creating some files!

<br />

### 2. Create `items` Schema

In creating a basic Todo List we only need one schema: `items`.
Later we can add separate lists and tags to organise/categorise
our `items` but for now this is all we need.

Run the following [generator](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html) command to create the items table:

```sh
mix phx.gen.html Todo Item items text:string person_id:integer status:integer
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
* creating lib/app/todo/item.ex
* creating priv/repo/migrations/20200521145424_create_items.exs
* creating lib/app/todo.ex
* injecting lib/app/todo.ex
* creating test/app/todo_test.exs
* injecting test/app/todo_test.exs

Add the resource to your browser scope in lib/app_web/router.ex:

    resources "/items", ItemController


Remember to update your repository by running migrations:

    $ mix ecto.migrate
```

That created a _bunch_ of files!
Some of which we don't strictly _need_. <br />
We could _manually_ create _only_ the files we _need_,
but this is the "official" way of creating a CRUD App in Phoenix,
so we are using it for speed.


> **Note**: Phoenix
[Contexts](https://hexdocs.pm/phoenix/contexts.html)
denoted in this example as `Todo`,
are "_dedicated modules that expose and group related functionality_."
We feel they _unnecessarily complicate_ basic Phoenix Apps
with layers of "interface" and we _really_ wish we could
[avoid](https://github.com/phoenixframework/phoenix/issues/3832) them.
But given that they are baked into the generators,
and the _creator_ of the framework
[_likes_](https://youtu.be/tMO28ar0lW8?t=376) them,
we have a choice: either get on board with Contexts
or _manually_ create all the files in our Phoenix projects.
Generators are a _much_ faster way to build!
_Embrace_ them,
even if you end up having to `delete` a few
unused files along the way!

We are _not_ going to explain each of these files
at this stage in the tutorial because
it's _easier_ to understand the files
as you are _building_ the App!
The purpose of each file will become clear
as you progress through editing them.



<br />

### 2.1 Add the `/items` Resources to `router.ex`

Follow the instructions noted by the generator to
add the `resources "/items", ItemController` to the `router.ex`.

Open the `lib/app_web/router.ex` file
and locate the line: `scope "/", AppWeb do` <br />
Add the line to the end of the block.
e.g:

```elixir
scope "/", AppWeb do
  pipe_through :browser

  get "/", PageController, :index
  resources "/items", ItemController # this is the new line
end
```

Your `router.ex` file should look like this:
[`router.ex#L20`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/f66184b58b7dd1ef593680e7a1a446247909cae7/lib/app_web/router.ex#L20)

<br />

### 2.2 _Run_ The App!

At this point we _already_ have a functional Todo List
(_if we were willing to use the default Phoenix UI_). <br />
Try running the app on your `localhost`:
Run the generated migrations with `mix ecto.migrate` then the server with:
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


Let's improve the UX by using the TodoMVC `HTML` and `CSS`!

<br />

### 3. Create the TodoMVC UI/UX

To recreate the TodoMVC UI/UX,
let's borrow the `HTML` code directly from the example.

Visit: http://todomvc.com/examples/vanillajs
add a couple of items to the list, <br />
then inspect the source
using your browser's
[Dev Tools](https://developers.google.com/web/tools/chrome-devtools/open).
e.g:

![todomvc-view-source](https://user-images.githubusercontent.com/194400/82698634-0b176780-9c63-11ea-9e1d-7aa6e2328766.png)

Right-click on the source you want
(e.g: `<section class="todoapp">`)
 and select "Edit as HTML":

![edit-as-html](https://user-images.githubusercontent.com/194400/82721624-b8679b00-9cb6-11ea-8d3f-2405f2bd301f.png)


Once the `HTML` for the `<section>` is editable,
select it and copy it.

![todomvc-html-editable-copy](https://user-images.githubusercontent.com/194400/82721711-b05c2b00-9cb7-11ea-85c2-083d2981440d.png)


The `HTML` code is:


```html
<section class="todoapp">
  <header class="header">
    <h1>todos</h1>
    <input class="new-todo" placeholder="What needs to be done?" autofocus="" />
  </header>
  <section class="main" style="display: block;">
    <input id="toggle-all" class="toggle-all" type="checkbox" />
    <label for="toggle-all">Mark all as complete</label>
    <ul class="todo-list">
      <li data-id="1590167947253" class="">
        <div class="view">
          <input class="toggle" type="checkbox" />
          <label>Learn how to build a Todo list in Phoenix</label>
          <button class="destroy"></button>
        </div>
      </li>
      <li data-id="1590167956628" class="completed">
        <div class="view">
          <input class="toggle" type="checkbox" />
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
    <button class="clear-completed" style="display: block;">
      Clear completed
    </button>
  </footer>
</section>
```

Let's convert this `HTML` to an Embedded Elixir
([`EEx`](https://hexdocs.pm/eex/EEx.html)) template.


> **Note**: the _reason_ that we are copying this `HTML`
from the browser's Elements inspector
instead of _directly_ from the source
on GitHub:
[`examples/vanillajs/index.html`](https://github.com/tastejs/todomvc/blob/c50cc922495fd76cb44844e3b1cd77e35a5d6be1/examples/vanillajs/index.html#L18)
is that this is a "single page app",
so the `<ul class="todo-list"></ul>`
only gets populated in the browser.
Copying it from the browser Dev Tools
is the easiest way to get the _complete_ `HTML`.

<br />

### 3.1 Paste the HTML into `index.html.eex`

Open the `lib/app_web/templates/item/index.html.eex` file
and scroll to the bottom.

Then (_without removing the code that is already there_)
paste the `HTML` code we sourced from TodoMVC.

> e.g:
[`/lib/app_web/templates/item/index.html.eex#L33-L73`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bddacda93ecd892fe0907210bab335e6b6e5e489/lib/app_web/templates/item/index.html.eex#L33-L73)

If you attempt to run the app now
and visit
[http://localhost:4000/items/](http://localhost:4000/items/) <br />
You will see this (_without the TodoMVC `CSS`_):

![before-adding-css](https://user-images.githubusercontent.com/194400/82725401-af85c200-9cd4-11ea-8717-714477fc3157.png)

That's obviously not what we want,
so let's get the TodoMVC `CSS`
and save it in our project!

<br />

### 3.2 Save the TodoMVC CSS to `/assets/css`

Visit
http://todomvc.com/examples/vanillajs/node_modules/todomvc-app-css/index.css <br />
and save the file to `/assets/css/todomvc-app.css`.

e.g:
[`/assets/css/todomvc-app.css`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/65bec23b92307527a414f77b667b29ea10619e5a/assets/css/todomvc-app.css)

<br />

### 3.3 Import the `todomvc-app.css` in `app.scss`

Open the `assets/css/app.scss` file and replace it with the following:

```css
/* This file is for your main application css. */
/* @import "./phoenix.css"; */
@import "./todomvc-app.css";
```

e.g:
[`/assets/css/app.scss#L3`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/5fd673089be616c9bb783277ae2d4f0e310b8413/assets/css/app.scss#L3)

We commented out the
`@import "./phoenix.css";`
because we don't want the Phoenix (Milligram) styles
_conflicting_ with the TodoMVC ones.

<br />

### 3.4 _Simplify_ The Layout Template

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
[`/lib/app_web/templates/layout/app.html.eex#L12`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1f2fdf6903c7a3c2f87e4340c12ac59303ce70ae/lib/app_web/templates/layout/app.html.eex#L12)

`<%= @inner_content %>` is where the Todo App will be rendered.

> **Note**: the `<script>` tag is included out of convention.
However, we won't be writing _any_ `JavaScript` in this tutorial.
We will achieve 100% feature parity with TodoMVC,
without writing a line of `JS`.
We don't "hate" `JS`,
in fact we have a "sister" tutorial
that builds the _same_ App in `JS`:
[dwyl/javascript-todo-list-tutorial](https://github.com/dwyl/javascript-todo-list-tutorial)
We just want to _remind_ you
that you don't _need_ any `JS`
to build a fully functional web application
with great UX!


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
in order to render our `item` data in the TodoMVC template. <br />
Let's create the first two which are fairly basic.

This is our first chance to do a bit of Test Driven Development (TDD). <br />
Create a new file with the path `test/app_web/views/item_view_test.exs`.

Type (_or paste_) the following code into the file:

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
and write the functions to make the tests _pass_.

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
and visit [`/items`](http://localhost:4000/items) <br />
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
Open the `lib/app/todo/item.ex` file
and replace the contents with the following:

```elixir
defmodule App.Todo.Item do
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


e.g:
[`/lib/app/todo/item.ex#L6-L7`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/cc287975eef5ca8b738f49723fe8a03d9da52a19/lib/app/todo/item.ex#L6-L7)


Now that we have `default` values for `person_id` and `status`
if you submit the `/items/new` form it will succeed.



### 5.2 Update `index/2` in `ItemController`

In order to in-line the new item form (`form.html.eex`)
in the `index.html.eex` template,
we need to update the `AppWeb.ItemController.index/2`
to include a Changeset.

Open the `lib/app_web/controllers/item_controller.ex` file
and update the `index/2` function to the following:

```elixir
def index(conn, _params) do
  items = Todo.list_items()
  changeset = Todo.change_item(%Item{})
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
[http://localhost:4000/items](http://localhost:4000/items) <br />
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
  items = []
  assert ItemView.remaining_items(items) == 0
end
```

e.g:
[`/test/app_web/views/item_view_test.exs#L21-L34`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/500775a87f61ce63f7845c054996a27bb1689098/test/app_web/views/item_view_test.exs#L21-L34)

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
in the bottom left of the TodoMVC UI is _working_! <br />
Add a `new` item to your list and watch the count increase:

![item-count-increases-to-2](https://user-images.githubusercontent.com/194400/82764853-fd501680-9e09-11ea-980e-d3bac18c8a33.gif)

That was easy enough let's try something a bit more advanced! <br />
Take a break and grab yourself a fresh glass of water,
the next section is going be _intense_!

<br />

### 7. Toggle a Todo Item's `status` to `1`

One of the core functions of a Todo List is
toggling the `status` of an `item` from `0` to `1` ("complete"). <br />
In our schema a completed `item`
has the `status` of `1`.


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
    toggled_item = Todo.get_item!(item.id)
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
  item = Todo.get_item!(id)
  Todo.update_item(item, %{status: toggle_status(item)})
  redirect(conn, to: Routes.item_path(conn, :index))
end
```

e.g:
[`/lib/app_web/controllers/item_controller.ex#L64-L75`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/dff006256b43b92a335472726fe43d464e23621d/lib/app_web/controllers/item_controller.ex#L64-L75)

The tests will still _fail_ at this point because
the route we are invoking in our test does not yet exist.
Let's fix that!

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

When this link is clicked
the `get /items/toggle/:id` endpoint is invoked, <br />
that in turn triggers the `toggle/2` handler
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
or the device is super old and does not have a modern web browser.
We could easily have added an `onclick` attribute to the `<input>` tag,
e.g:

```html
<input <%= checked(item) %> type="checkbox" class="toggle"
onclick="location.href='
  <%= Routes.item_path(@conn, :toggle, item.id) %>';">
```

But `onclick` is `JavaScript` and we don't _need_ to resort to `JS`. <br />
The `<a>` (link) is a perfectly semantic non-js approach to toggling
`item.status`.


<br />

### 8. _Edit_ an Item!

The final piece of _functionality_
we need to add to our UI
is the ability to _edit_ an item's text.

At the end of this step you will have in-line editing working:

![phoenix-todo-item-inline-editing](https://user-images.githubusercontent.com/194400/83204049-bf712c00-a142-11ea-8560-d68cf79a4fea.gif)


### 8.1 Double-Click Item Text to Edit

The _reason_ for requiring two clicks to edit an item,
is so that people don't _accidentally_ edit an item while scrolling.
So they have to deliberately click/tap _twice_ in order to edit.

In the TodoMVC spec this is achieved
by creating an event listener for the double-click event
and replacing the `<label>` element with an `<input>`.
We are trying to _avoid_ using `JavaScript`
in our server-side rendered Phoenix App (_for now_),
so we want to use an alternative approach.
Thankfully we can simulate the double-click event
using just `HTML` and `CSS`.
see: https://css-tricks.com/double-click-in-css
(_we recommend reading that post and the Demo
  to fully understand how this CSS works_!)

> **Note**: the CSS implementation is not a _true_ double-click,
a more accurate description would be "two click"
because the two clicks can occur with an arbitrary delay.
i.e. first click followed by 10sec wait and second click
will have the same effect as two clicks in quick succession.
If you want to implement true double-click,
see:
[github.com/dwyl/javascript-todo-list-tutorial#52-double-click](https://github.com/dwyl/javascript-todo-list-tutorial/tree/e6736add9df1f46035f8a9d1dbdc14c71a7cdb41#52-double-click-item-label-to-edit)

Let's get on with it!
Open the
`lib/app_web/templates/item/index.html.eex`
file and locate the line:

```elixir
<%= render "form.html", Map.put(assigns, :action, Routes.item_path(@conn, :create)) %>
```

Replace it with:

```elixir
<%= if @editing.id do %>
  <a href="<%= Routes.item_path(@conn, :index) %>" class="new-todo">
    Click here to create a new item!
  </a>
<% else %>
  <%= render "form.html", Map.put(assigns, :action, Routes.item_path(@conn, :create)) %>
<% end %>
```

This code is the first `if/else` block in our project.
It checks if we are editing an item,
and renders a link instead of the form,
we do this to avoid having multiple forms on the page.
If we are _not_ editing an item,
render the `form.html` as before.

e.g:
[`lib/app_web/templates/item/index.html.eex#L35-L41`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/68f2a337a18e78f2bdfb98fe480b5e262c668844/lib/app_web/templates/item/index.html.eex#L35-L39)

_Next_, still in the `index.html.eex` file,
locate the line:

```html
<div class="view">
```

Replace the `<a>` tag with the following code:

```elixir
<%= if item.id == @editing.id do %>
  <%= render "form.html", Map.put(assigns, :action,
    Routes.item_path(@conn, :update, item)) %>
<% else %>
  <a href="<%= Routes.item_path(@conn, :edit, item) %>" class="dblclick">
    <label><%= item.text %></label>
  </a>
  <span></span> <!-- used for CSS Double Click -->
<% end %>
```

e.g:
[`lib/app_web/templates/item/index.html.eex#L56-L64`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/68f2a337a18e78f2bdfb98fe480b5e262c668844/lib/app_web/templates/item/index.html.eex#L56-L64)

The `else` block renders a link (`<a>`),
which when clicked will render the App in "edit" mode.
We will make the adjustments to the controller
to enable editing in the `index.html` template shortly.
The `<span></span>` as the comment suggests,
is only there for the CSS double-click effect.

<br />

### 8.2 Update `CSS` For Editing

To enable the CSS double-click effect,
we need to add the following CSS
to our `assets/css/app.scss` file:

```css
.dblclick {
  position: relative; /* So z-index works later, but no surprises now */
}

.dblclick + span {
  position: absolute;
  top: -1px; /* these negative numbers are to ensure */
  left: -1px; /* that the <span> covers the <a> */
  width: 103%; /* Gotta do this instead of right: 0; */
  bottom: -1px;
  z-index: 1;
}

.dblclick + span:active {
  left: -9999px;
}

.dblclick:hover {
  z-index: 2;
}
```

e.g:
[`assets/css/app.scss#L48-L67`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3894013996d4d19f825c57216438653458d0bd80/assets/css/app.scss#L48-L67)


Additionally, since our markup is _slightly_ different
to the TodoMVC markup, we need to add a bit more CSS
to keep the UI consistent:

```css
.todo-list li .toggle + div > a > label {
  background-image: url('data:image/svg+xml;utf8,%3Csvg%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%20width%3D%2240%22%20height%3D%2240%22%20viewBox%3D%22-10%20-18%20100%20135%22%3E%3Ccircle%20cx%3D%2250%22%20cy%3D%2250%22%20r%3D%2250%22%20fill%3D%22none%22%20stroke%3D%22%23ededed%22%20stroke-width%3D%223%22/%3E%3C/svg%3E');
  background-repeat: no-repeat;
  background-position: center left;
}

.todo-list li .checked + div > a > label
{
  background-image: url('data:image/svg+xml;utf8,%3Csvg%20xmlns%3D%22http%3A//www.w3.org/2000/svg%22%20width%3D%2240%22%20height%3D%2240%22%20viewBox%3D%22-10%20-18%20100%20135%22%3E%3Ccircle%20cx%3D%2250%22%20cy%3D%2250%22%20r%3D%2250%22%20fill%3D%22none%22%20stroke%3D%22%23bddad5%22%20stroke-width%3D%223%22/%3E%3Cpath%20fill%3D%22%235dc2af%22%20d%3D%22M72%2025L42%2071%2027%2056l-4%204%2020%2020%2034-52z%22/%3E%3C/svg%3E');
  background-repeat: no-repeat;
  background-position: center left;
}

.toggle {
  width: 10%;
  z-index: 3; /* keep the toggle checkmark above the rest */
}

a.new-todo {
  display: block;
  text-decoration: none;
}

.todo-list .new-todo {
  border: 1px #1abc9c solid;
}

.view a, .view a:visited {
  display: block;
  text-decoration: none;
  color: #2b2d2f;
}

.todo-list li .destroy {
  text-decoration: none;
  text-align: center;
  z-index: 3; /* keep the delete link above the text */
}
```

This is what your `app.scss` file should look like
at the end of this step:
[`assets/css/app.scss#L7-L44`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3894013996d4d19f825c57216438653458d0bd80/assets/css/app.scss#L7-L44)

<br />

### 8.3 Update the `ItemController.edit/2` Function

In order to enable in-line editing,
we need to modify the `edit/2` function.
Open the `lib/app_web/controllers/item_controller.ex` file
and replace the `edit/2` function with the following:

```elixir
def edit(conn, params) do
  index(conn, params)
end
```

Additionally, given that we are asking our `index/2` function
to handle editing, we need to update `index/2`:

```elixir
def index(conn, params) do
  item = if not is_nil(params) and Map.has_key?(params, "id") do
    Todo.get_item!(params["id"])
  else
    %Item{}
  end
  items = Todo.list_items()
  changeset = Todo.change_item(item)
  render(conn, "index.html", items: items, changeset: changeset, editing: item)
end
```

Your `item_controller.ex` file should now look like this:
[`lib/app_web/controllers/item_controller.ex#L7-L16`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/404ad984a1c5f7650c948997f29521dbdda5ae4c/lib/app_web/controllers/item_controller.ex#L7-L16)

<br />

### 8.4 Update the Tests in `ItemControllerTest`

In our quest to build a _Single_ Page App,
we broke another test! That's OK. It's easy to fix.

Open the
`test/app_web/controllers/item_controller_test.exs`
file and locate the test
that has the following description:

```elixir
test "renders form for editing chosen item"
```

Update the assertion from:

```elixir
assert html_response(conn, 200) =~ "Edit Item"
```

To:

```elixir
assert html_response(conn, 200) =~ item.text
```

e.g:
[`test/app_web/controllers/item_controller_test.exs#L51`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/32ba6ea2a78f0317519a18c133e3c7e8c4eaf9c7/test/app_web/controllers/item_controller_test.exs#L51)


Next, locate the test with the following description:

```elixir
test "redirects when data is valid"
```

Update the assertion from:

```elixir
assert redirected_to(conn) == Routes.item_path(conn, :show, item)
```

To:

```elixir
assert redirected_to(conn) == Routes.item_path(conn, :index)
```

e.g:
[`test/app_web/controllers/item_controller_test.exs#L60`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/32ba6ea2a78f0317519a18c133e3c7e8c4eaf9c7/test/app_web/controllers/item_controller_test.exs#L60)

If you run the tests now, they should pass again:

```
mix test

23:08:01.785 [info]  Already up
...........................

Finished in 0.5 seconds
27 tests, 0 failures

Randomized with seed 956565
```

<br />

### 8.5 Remove Old Template from `index.html`

Now that we have the `toggle` and `edit` features working,
we can finally remove the default Phoenix (table) layout
from the `index.html.eex` template.

<img width="872" alt="phoenix-todo-list-table-layout" src="https://user-images.githubusercontent.com/194400/83200932-54245b80-a13c-11ea-92a3-6b55fc2b2652.png">

Open the `lib/app_web/templates/item/index.html.eex` file
and remove all code before the line:
```html
<section class="todoapp">
```

e.g:
[commits/3f5e3e](https://github.com/dwyl/phoenix-todo-list-tutorial/pull/35/commits/3f5e3e3c0e9e745c0c76fdc7f078d05e632a13eb)

Your app should now look like this:
![phoenix-todo-app-without-default-table-layout](https://user-images.githubusercontent.com/194400/83201568-afa31900-a13d-11ea-9511-aadb5988cc23.png)

Unfortunately, by removing the default layout,
we have "broken" the tests.

Open the
`test/app_web/controllers/item_controller_test.exs`
file and locate the test
that has the following description:

```elixir
test "lists all items"
```

Update the assertion from:

```elixir
assert html_response(conn, 200) =~ "Listing Items"
```

To:

```elixir
assert html_response(conn, 200) =~ "todos"
```

e.g:
[`test/app_web/controllers/item_controller_test.exs#L18`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/60e6d0240ac4c1f42ee7c7ee94db6175242bd2f0/test/app_web/controllers/item_controller_test.exs#L18)

<br />

### 9. Footer Navigation

Now that the core (create, edit/update, delete) functionality is working,
we can add the final UI enhancements.
In this step we are going to add the footer navigation/filtering.

<img width="581" alt="phoenix-todo-footer-navigation" src="https://user-images.githubusercontent.com/194400/83204791-96ea3180-a144-11ea-954b-499a4348ef32.png">

The "All" view is the default.
The "Active" is all the items with `status==0`.
"Completed" is all items with `status==1`.

<br />

### 9.1 Create `/:filter` Route

Open the `lib/app_web/router.ex` and
add the following route:

```elixir
get "/:filter", ItemController, :index
```

e.g:
[`/lib/app_web/router.ex#L22`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/fcdc3a64a31e6608876d4c290a0424e31f2603f4/lib/app_web/router.ex#L22)

<br />

### 9.2 Update the Controller `index/2` to send `filter` to View/Template

Open the `lib/app_web/controllers/item_controller.ex` file
and locate the `index/2` function.
Replace the invocation of `render/3` at the end of `index/2`
with the following:

```elixir
render(conn, "index.html",
  items: items,
  changeset: changeset,
  editing: item,
  filter: Map.get(params, "filter", "all")
)
```

e.g:
[`lib/app_web/controllers/item_controller.ex#L22`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1f744e316392398c6ba47ca02303d9a4e5674c0d/lib/app_web/controllers/item_controller.ex#L22)

`Map.get(params, "filter", "all")`
sets the default value of our `filter` to "all"
so when `index.html` is rendered, show "all" items.

<br />

### 9.3 Create `filter/2` and `selected/2` View Functions

In order to filter the items by their status,
we need to create a new function. <br />
Open the `lib/app_web/views/item_view.ex` file
and create the `filter/2` function as follows:

```elixir
def filter(items, str) do
  case str do
    "all" -> items
    "active" -> Enum.filter(items, fn i -> i.status == 0 end)
    "completed" -> Enum.filter(items, fn i -> i.status == 1 end)
  end
end
```

e.g:
[`lib/app_web/views/item_view.ex#L28-L34`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/b27b0c9eb63afccf114c3b9af3d9236ded2ea638/lib/app_web/views/item_view.ex#L28-L34)

This will allow us to filter the items in the next step.

The other view function we need,
will help our view know which filter is selected
so that the UI can reflect it correctly.
Add the following definition for `selected/2`:

```elixir
def selected(filter, str) do
  case filter == str do
    true -> "selected"
    false -> ""
  end
end
```

e.g:
[`lib/app_web/views/item_view.ex#L36-L41`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/b27b0c9eb63afccf114c3b9af3d9236ded2ea638/lib/app_web/views/item_view.ex#L36-L41)

This will set the "selected" class
which will select the appropriate tab
in the footer navigation.


<br />

### 9.4 Update the Footer in the `index.html` Template

Use the `filter/2` function to filter the items that are displayed.
Open the `lib/app_web/templates/item/index.html.eex` file
and locate the `for` loop line:

```elixir
<%= for item <- @items do %>
```

Replace it with:

```elixir
<%= for item <- filter(@items, @filter) do %>
```
e.g:
[`lib/app_web/templates/item/index.html.eex#L17`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/cce1f0bbb13d14ce7f9ae1e7865976a235829271/lib/app_web/templates/item/index.html.eex#L17)

This invokes the `filter/2` function we defined in the previous step
passing in the list of `@items` and the selected `@filter`.


Next, locate the the `<footer>`
and replace the _contents_
of the
`<ul class="filters">`
with the following code:

```elixir
<li>
  <a href="/items" class='<%= selected(@filter, "all") %>'>
    All
  </a>
</li>
<li>
  <a href="/active" class='<%= selected(@filter, "active") %>'>
    Active
    [<%= Enum.count(filter(@items, "active")) %>]
  </a>
</li>
<li>
  <a href="/completed" class='<%= selected(@filter, "completed") %>'>
    Completed
    [<%= Enum.count(filter(@items, "completed")) %>]
  </a>
</li>
```

e.g:
[`/lib/app_web/templates/item/index.html.eex#L46-L64`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/c613567b6eb85e62c1be4a1ffe0e02b7fdd8754a/lib/app_web/templates/item/index.html.eex#L46-L64)

At the end of this step you will have a
fully functioning footer filter:

![phoenix-todo-footer-nav](https://user-images.githubusercontent.com/194400/83212591-ea19af80-a157-11ea-9e0b-502af5cb61b2.gif)


<br />

### 10. Clear Completed

We are _almost_ done with our Phoenix implementation of TodoMVC.
The last thing to implement is "clear completed".

Open your `lib/app_web/router.ex` file
and add the following route:

```elixir
get "/clear", ItemController, :clear_completed
```

e.g:
[`lib/app_web/router.ex#L22`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/cf4aa02c1b98e9900c0366a4f82993d91aaa27e2/lib/app_web/router.ex#L22)

In the `lib/app_web/controllers/item_controller.ex`
file add the following code:

```elixir
import Ecto.Query
alias App.Repo

def clear_completed(conn, _param) do
  person_id = 0
  query = from(i in Item, where: i.person_id == ^person_id, where: i.status == 1)
  Repo.update_all(query, set: [status: 2])
  # render the main template:
  index(conn, %{filter: "all"})
end
```

e.g:
[`lib/app_web/controllers/item_controller.ex#L88-L97`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/697059b518e41c312f995882ffb444a75925082e/lib/app_web/controllers/item_controller.ex#L88-L97)

This uses the handy
[`update_all/3`](https://hexdocs.pm/ecto/2.0.0-rc.5/Ecto.Repo.html#c:update_all/3)
function to update all items that match the `query`.
In our case we searching for all `items`
that belong to `person_id==0`
and have `status==1`.

We are not _deleting_ the items,
rather we are updating their status to `2`
which for the purposes of our example means they are "archived".

> **Note**: This is a useful guide to `update_all`:
https://adamdelong.com/bulk-update-ecto


Finally, in the `lib/app_web/templates/item/index.html.eex`
scroll to the bottom of the file and replace the line:

```elixir
<button class="clear-completed" style="display: block;">Clear completed</button>
```

With:

```elixir
<a class="clear-completed" href="/clear">
  Clear completed
  [<%= Enum.count(filter(@items, "completed")) %>]
</a>
```

e.g:
[`lib/app_web/templates/item/index.html.eex#L65-L68`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/69b4d2c5f6e8bc9ab9eea0db131bec34e6f8bc9a/lib/app_web/templates/item/index.html.eex#L65-L68)


At the end of this section your Todo List
should have the "Clear completed" function working:

![phoenix-todo-clear-completed](https://user-images.githubusercontent.com/194400/83244744-a3e44080-a197-11ea-90b3-5420f98bbd55.gif)


<br />

### 11. Tidy Up! (_Optional?_)

At this point we already have a fully functioning Phoenix Todo List.
There are a few things we can tidy up to make the App _even_ better!


### 11.1 _Pluralise_ Items Left

If you are the type of person to notice the _tiny_ details,
you would have been
[_itching_](https://en.wikipedia.org/wiki/Obsessive%E2%80%93compulsive_disorder)
each time you saw
the "***1 items left***" in the bottom left corner:

![phoenix-todo-pluralisation-BEFORE](https://user-images.githubusercontent.com/194400/83249677-dc3b4d00-a19e-11ea-8176-2f38725c3b50.png)

Open your `test/app_web/views/item_view_test.exs` file
and add the following test:

```elixir
test "pluralise/1 returns item for 1 item and items for < 1 <" do
  assert ItemView.pluralise([%{text: "one", status: 0}]) == "item"
  assert ItemView.pluralise([
    %{text: "one", status: 0},
    %{text: "two", status: 0}
  ]) == "items"
  assert ItemView.pluralise([%{text: "one", status: 1}]) == "items"
end
```

e.g:
[`test/app_web/views/item_view_test.exs#L41-L47`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/45ac34efe681fe2b6b54a0b352d76b4b24785ed0/test/app_web/views/item_view_test.exs#L41-L47)


This test will obviously _fail_ because the
`AppWeb.ItemView.pluralise/1` is undefined.
Let's make it pass!

Open your `lib/app_web/views/item_view.ex` file
and add the following function definition for `pluralise/1`:

```elixir
# pluralise the word item when the number of items is greather/less than 1
def pluralise(items) do
  # items where status < 1 is equal to Zero or Greater than One:
  case remaining_items(items) == 0 || remaining_items(items) > 1 do
    true -> "items"
    false -> "item"
  end
end
```

e.g:
[`lib/app_web/views/item_view.ex#L43-L50`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1020bff5748e8a9b16d6e21650dc9204a3da663e/lib/app_web/views/item_view.ex#L43-L50)

> **Note**: we are only pluralising one word in our basic Todo App
so we are only handling this one case in our `pluralise/1` function.
In a more advanced app we would use a translation tool
to do this kind of pluralising.
See: https://hexdocs.pm/gettext/Gettext.Plural.html

Finally, _use_ the `pluralise/1` in our template.
Open `lib/app_web/templates/item/index.html.eex`

Locate the line:

```elixir
<span class="todo-count"><%= remaining_items(@items) %> items left</span>
```

And replace it with the following code:

```elixir
<span class="todo-count">
  <%= remaining_items(@items) %> <%= pluralise(@items) %> left
</span>
```

e.g:
[`lib/app_web/views/item_view.ex#L47-L49`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1020bff5748e8a9b16d6e21650dc9204a3da663e/lib/app_web/templates/item/index.html.eex#L47-L49)

At the end of this step
you will have a working pluralisation
for the word item/items in the bottom left of the UI:

![phx-todo-pluralise-demo](https://user-images.githubusercontent.com/194400/83257010-6ab5cb80-a1ab-11ea-93e7-e95a9fb256c1.gif)


### 11.2 Hide Footer When There Are _Zero_ Items

If you visit one of the TodoMVC examples, you will see that no `<footer>` is displayed when there are no items in the list: http://todomvc.com/examples/vanillajs

![todo-mvc-vanilla-](https://user-images.githubusercontent.com/194400/83250460-0fcaa700-a1a0-11ea-8f05-f399233fad4d.png)

At present our App _shows_ the `<footer>`
even if their are Zero items: 🤦

<img width="849" alt="phoenix-todo-zero-items" src="https://user-images.githubusercontent.com/194400/83250895-b3b45280-a1a0-11ea-8f13-d54470cf278a.png">

This is a visual distraction/clutter
that creates
[unnecessary questions](https://en.wikipedia.org/wiki/Don%27t_Make_Me_Think)
in the user's mind.
Let's fix it!

Open your `lib/app_web/views/item_view.ex` file
and add the following function definition `unarchived_items/1`:

```elixir
def got_items?(items) do
  Enum.filter(items, fn i -> i.status < 2 end) |> Enum.count > 0
end
```

e.g:
[`lib/app_web/views/item_view.ex#L52-L55`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/b36765774d4beed0812b3070ecb942e9b97d3800/lib/app_web/views/item_view.ex#L52-L55)


Now _use_ `got_items?/1` in the template.

Wrap the `<footer>` element in the following `if` statement:

```elixir
<%= if got_items?(@items) do %>

<% end %>
```

e.g:
[`lib/app_web/templates/item/index.html.eex#L45`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/fbf22d58eb83a164961cf9c52bff645989c2f424/lib/app_web/templates/item/index.html.eex#L45-L74)


The convention in Phoenix/Elixir (_which came from Ruby/Rails_)
is to have a `?` (question mark) in the name of functions
that return a Boolean (`true/false`) result.

At the end of this step our `<footer>` element
is hidden when there are no items:

![phx-todo-footer-hidden](https://user-images.githubusercontent.com/194400/83268893-2bdd4100-a1be-11ea-88ac-f99f7e6efeda.gif)

<br />

### 11.3 Route `/` to `ItemController.index/2`

The final piece of tidying up we can do is
to change the Controller that gets invoked for the "homepage" (`/`)
of our app.
Currently when the person viewing the Todo App  
visits [`http://localhost:4000/`](http://localhost:4000)
they see the `lib/app_web/templates/page/index.html.eex` template:

![page_template](https://user-images.githubusercontent.com/194400/83269042-6941ce80-a1be-11ea-80fa-73674576e928.png)

This is the default Phoenix home page
(_minus the CSS Styles and images that we removed in step 3.4 above_).
It does not tell us anything about the actual app we have built,
it doesn't even have a _link_ to the Todo App!
Let's fix it!

Open the `lib/app_web/router.ex` file and locate the line:
```elixir
get "/", PageController, :index
```

Update the controller to: `ItemController` e.g:

```elixir
get "/", ItemController, :index
```

e.g:
[`lib/app_web/router.ex#L19`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/82f90706a6a89c040ea552701565fc3a06888961/lib/app_web/router.ex#L19)

Now when you run your App you will see the todo list on the home page:

![todo-app-on-homepage](https://user-images.githubusercontent.com/194400/83270006-cbe79a00-a1bf-11ea-8972-91097fdabdc1.png)


Unfortunately,
this update will "break" the page test.
Run the tests and see:

```sh
1) test GET / (AppWeb.PageControllerTest)
     test/app_web/controllers/page_controller_test.exs:4
     Assertion with =~ failed
     code:  assert html_response(conn, 200) =~ "Welcome to Phoenix!"
     left:  "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n ..."
```

Given that we are no longer _using_ the `Page`
Controller, View, Template or Tests,
we might as well **`delete`** them from our project!

```sh
git rm lib/app_web/controllers/page_controller.ex
git rm lib/app_web/templates/page/index.html.eex
git rm lib/app_web/views/page_view.ex
git rm test/app_web/controllers/page_controller_test.exs
```

Deleting files is good hygiene in any software project.
Don't be _afraid_ to do it, you can always recover files
that are in your `git` history.

Re-run the tests:

```
mix test
```

You should see them pass now:

```
...........................

Finished in 0.5 seconds
27 tests, 0 failures
```

<br />

### 11.4 Add Turbolinks to Eliminate Page Refresh

Given that our Phoenix Todo List App is 100% server rendered,
older browsers will perform a full page refresh
when an action (create/edit/toggle/delete) is performed.
This will feel like a "blink" in the page
and on **_really_ slow connections**
it will result in a temporary **_blank_ page**!
Obviously, that's _horrible_ UX and is a big part of why
Single Page Apps (SPAs) became popular;
to avoid page refresh, use
**[Turbolinks](https://github.com/turbolinks/turbolinks)®**!

Get the performance benefits of an SPA
without the added complexity
of a client-side JavaScript framework.
When a link is clicked/tapped,
Turbolinks automatically fetches the page,
swaps in its `<body>`, and merges its `<head>`,
all without incurring the cost of a full page load.


Add [turbolinks package](https://www.npmjs.com/package/turbolinks)
to `/assets/package.json`:

```sh
cd assets && npm install turbolinks --save
```

e.g:
[`/assets/package.json#L18`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1f2fdf6903c7a3c2f87e4340c12ac59303ce70ae/assets/package.json#L18)

In `assets/app.js` import Turbolinks and start it:

```js
import Turbolinks from "turbolinks"
Turbolinks.start();
```

e.g:
[`assets/js/app.js#L16-L17`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/1f2fdf6903c7a3c2f87e4340c12ac59303ce70ae/assets/js/app.js#L16-L17)

That's it!
Now when you deploy your server rendered Phoenix App,
it will _feel_ like an SPA!
Seriously, try the Heroku demo again:
[phxtodo.herokuapp.com](https://phxtodo.herokuapp.com/)
Feel that buttery-smooth page transition.


<br />

### Deploy!

Deployment to Heroku takes a few minutes,
but has a few "steps",
therefore we have created a _separate_
guide for it:
 [elixir-phoenix-app-deployment.md](https://github.com/dwyl/learn-heroku/blob/master/elixir-phoenix-app-deployment.md)

Once you have _deployed_ you will will be able
to view/use your app in any Web/Mobile Browser.

e.g: https://phxtodo.herokuapp.com <br />

![todo-app-heroku-version](https://user-images.githubusercontent.com/194400/83279718-6e5a4a00-a1cd-11ea-90b3-f0b29a898b3d.gif)

<br />




### Done!

<br />

## What _Next_?

If you found this example useful,
please ⭐️ the GitHub repository
so we (_and others_) know you liked it!

If you want to learn more Phoenix
and the magic of **`LiveView`**,
consider reading our beginner's tutorial:
[github.com/dwyl/**phoenix-liveview-counter-tutorial**](https://github.com/dwyl/phoenix-liveview-counter-tutorial)

Thank you for learning with us! ☀️


<br />

<!--
### Part 2: Authentication!
-->





<br />

## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
  + Phoenix Chat Tutorial:
  https://github.com/dwyl/phoenix-chat-example
  + Phoenix LiveView Counter Tutorial:
  https://github.com/dwyl/phoenix-liveview-counter-tutorial
