<div align="center">

# Phoenix Todo List Tutorial

A complete beginners step-by-step tutorial
for building a Todo List in Phoenix.<br/>
100% functional. 0% JavaScript. Just `HTML`, `CSS` and `Elixir`.
Fast and maintainable.

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dwyl/phoenix-todo-list-tutorial/Elixir%20CI?label=build&style=flat-square)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](http://codecov.io/github/dwyl/phoenix-todo-list-tutorial?branch=master)
[![HitCount](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial.svg)](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/phoenix-todo-list-tutorial/issues)

</div>
<br />


## Why? 🤷‍

Todo lists are familiar to most people;
we make lists all the time.
_Building_ a Todo list from scratch
is a great way to learn Elixir/Phoenix
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


### Try it on Heroku: [phxtodo.fly.dev](https://phxtodo.fly.dev)

<!-- wake heroku app before visit. see: https://github.com/dwyl/ping -->
![wake-sleeping-heroku-app](https://phxtodo.fly.dev/ping)


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

![welcome-to-phoenix](https://user-images.githubusercontent.com/17494745/206515843-2b4da196-f039-4caf-a4d2-fc316eabb2c5.png)


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
* creating lib/app_web/controllers/item_html/edit.html.heex
* creating lib/app_web/controllers/item_html/index.html.heex
* creating lib/app_web/controllers/item_html/new.html.heex
* creating lib/app_web/controllers/item_html/show.html.heex
* creating lib/app_web/controllers/item_html.ex
* creating test/app_web/controllers/item_controller_test.exs
* creating lib/app/todo/item.ex
* creating priv/repo/migrations/20221205102303_create_items.exs
* creating lib/app/todo.ex
* injecting lib/app/todo.ex
* creating test/app/todo_test.exs
* injecting test/app/todo_test.exs
* creating test/support/fixtures/todo_fixtures.ex
* injecting test/support/fixtures/todo_fixtures.ex

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
and locate the line: `scope "/", AppWeb do`.
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
[`router.ex#L20`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/b158abd7f0c3fbc462a4230f07b5e5e79723a258/app/lib/app_web/router.ex#L17-L22)

Now, as the terminal suggested,
run `mix ecto.migrate`.
This will finish setting up the
database tables and run the 
necessary migrations so 
everything works properly!

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

![todo-list-phoenix-default-ui](https://user-images.githubusercontent.com/17494745/205615474-1eef8b42-86aa-4a0e-90c3-376221570255.png)

Click the "Save Item" button
and you will be redirected to the "show" page:
http://localhost:4000/items/1

![todo-list-phoenix-default-ui-show-item](https://user-images.githubusercontent.com/17494745/205615709-922db20e-245d-4af0-a5e3-2bbaa29771b4.png)

This is not an attractive User Experience (UX),
but it _works_!
Here is a _list_ of items - a "Todo List".
You can visit this by clicking
the `Back to items` button or by 
accessing the following URL
http://localhost:4000/items.

![todo-list-phoenix-default-ui-show-items-list](https://user-images.githubusercontent.com/17494745/205616098-a514d2bb-af28-477a-b80a-6641c5b391a9.png)


Let's improve the UX by using the TodoMVC `HTML` and `CSS`!

### 3. Create the TodoMVC UI/UX

To recreate the TodoMVC UI/UX,
let's borrow the `HTML` code directly from the example.

Visit: http://todomvc.com/examples/vanillajs
add a couple of items to the list.
Then, inspect the source
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

Open the `lib/app_web/controllers/item_html/index.html.eex` file
and scroll to the bottom.

Then (_without removing the code that is already there_)
paste the `HTML` code we sourced from TodoMVC.

> e.g:
[`/lib/app_web/controllers/item_html/index.html.eex#L27-L73`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8bcc3239d975f5b706514d1a88ea47ca57e5239a/lib/app_web/controllers/item_html/index.html.heex#L27-L73)

If you attempt to run the app now
and visit
[http://localhost:4000/items/](http://localhost:4000/items/) <br />
You will see this (_without the TodoMVC `CSS`_):

![before-adding-css](https://user-images.githubusercontent.com/17494745/205656501-b3170bc4-c8a7-403f-9db9-2823c839f61e.png)

That's obviously not what we want,
so let's get the TodoMVC `CSS`
and save it in our project!

<br />

### 3.2 Save the TodoMVC CSS to `/assets/css`

Visit
http://todomvc.com/examples/vanillajs/node_modules/todomvc-app-css/index.css <br />
and save the file to `/assets/css/todomvc-app.css`.

e.g:
[`/assets/css/todomvc-app.css`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/assets/css/todomvc-app.css)

<br />

### 3.3 Import the `todomvc-app.css` in `app.scss`

Open the `assets/css/app.scss` file and replace it with the following:

```css
/* This file is for your main application css. */
/* @import "./phoenix.css"; */
@import "./todomvc-app.css";
```

e.g:
[`/assets/css/app.scss#L4`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8bcc3239d975f5b706514d1a88ea47ca57e5239a/assets/css/app.css#L4)

<br />

### 3.4 _Simplify_ The Layout Template

Open your `lib/app_web/components/layouts/app.html.eex` file
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
[`lib/app_web/components/layouts/app.html.eex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bddacda93ecd892fe0907210bab335e6b6e5e489/lib/app_web/templates/layout/app.html.eex) <br />
> After:
[`lib/app_web/components/layouts/app.html.eex#L12`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8bcc3239d975f5b706514d1a88ea47ca57e5239a/lib/app_web/components/layouts/app.html.heex#L12)

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
the TodoMVC CSS file saved to `/assets/css/todomvc-app.css`
and the `todomvc-app.css` imported in `app.scss`,
your `/items` page should now look like this:

![items-with-todomvc-css](https://user-images.githubusercontent.com/17494745/205660411-7b199ec5-289e-4863-8a67-9c22e9dc78dd.png)


So our Todo List is starting to look like TodoMVC,
but it's still just a dummy list.


### 4. Render _Real_ Data in the TodoMVC Layout

In order to render out `item` data
in the TodoMVC template, 
we are going to need to add
a few functions. 
When we created the project
and generated the `item` model,
a controller was created 
(located in `lib/app_web/controllers/item_controller.ex`)
and a component/view as well
(located in `lib/app_web/controllers/item_html.ex`).
This [**Component/View**](https://hexdocs.pm/phoenix/1.7.0-rc.0/components.html)
is what effectively 
controls the rendering of the 
contents inside the
`lib/app_web/controllers/item_html`
directory that we tinkered with prior.

We know that we need make changes to the UI,
so we are going to add a few functions in this component
(which is akin to the *View* part of the MVC paradigm).

This is our first chance to do a bit of Test Driven Development (TDD). <br />
Create a new file with the path `test/app_web/controllers/item_html_test.exs`.

Type the following code into the file:

```elixir
defmodule AppWeb.ItemHTMLTest do
  use AppWeb.ConnCase, async: true
  alias AppWeb.ItemHTML

  test "complete/1 returns completed if item.status == 1" do
    assert ItemHTML.complete(%{status: 1}) == "completed"
  end

  test "complete/1 returns empty string if item.status == 0" do
    assert ItemHTML.complete(%{status: 0}) == ""
  end
end
```

e.g:
[`/test/app_web/controllers/item_html_test.exs`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8bcc3239d975f5b706514d1a88ea47ca57e5239a/test/app_web/controllers/item_html_test.exs)


If you attempt to run this test file:

```sh
mix test test/app_web/controllers/item_html_test.exs
```

You will see the following error (because the function does not yet exist!):

```
** (UndefinedFunctionError) function AppWeb.ItemHTML.checked/1 is undefined or private
```

Open the
`lib/app_web/controllers/item_html.ex` file
and write the functions to make the tests _pass_.

<br />

This is how we implemented the functions.
Your `item_html.ex` file 
now should look like the following.

```elixir
defmodule AppWeb.ItemHTML do
  use AppWeb, :html
  
  embed_templates "item_html/*"

  # add class "completed" to a list item if item.status=1
  def complete(item) do
    case item.status do
      1 -> "completed"
      _ -> "" # empty string means empty class so no style applied
    end
  end
end
```

Re-run the tests and they should now pass:

```sh
mix test test/app_web/controllers/item_html_test.exs
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

Open the `lib/app_web/controllers/item_html/index.html.eex` file
and locate the line:

```html
<ul class="todo-list">
```

Replace the _contents_ of the `<ul>` with the following:

```html
<%= for item <- @items do %>
  <li data-id={item.id} class={complete(item)}>
    <div class="view">
      <%= if item.status == 1 do %>
        <input class="toggle" type="checkbox" checked/>
      <% else %>
        <input class="toggle" type="checkbox"/>
      <% end %>
      <label><%= item.text %></label>
      <.link
        class="destroy"
        href={~p"/items/#{item}"}
        method="delete"
      >
      </.link>
    </div>
  </li>
<% end %>
```

e.g:
[`lib/app_web/controllers/item_html/index.html.heex#L43-L53`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3c04ee39df621cac200b4d3b45ad4045e67e388b/lib/app_web/controllers/item_html/index.html.heex#L36-L56)


With those two files saved,
if you run the app now: `mix phx.server`
and visit http://localhost:4000/items. <br />
You will see the _real_ `items` you created in step 2.2 above:

![todo-list-real-items](https://user-images.githubusercontent.com/17494745/205710983-e079f021-c91d-4be8-9a5e-0a6b0bc85fb8.png)


Now that we have our items rendering in the TodoMVC layout,
let's work on creating new items in the "single page app" style.


### 5. In-line the New Item Creation Form

At present our "New Item" form is available at:
http://localhost:4000/items/new
(_as noted in step 2 above_)

We want the person to be able to create a new item
without having to navigate to a different page.
In order to achieve that goal,
we will include the 
`lib/app_web/controllers/item_html/new.html.heex`
template (_partial_)
inside the 
`lib/app_web/controllers/item_html/index.html.heex`
template. e.g:

Before we can do that, we need to tidy up the `new.html.heex`
template to remove the fields we don't _need_.

Let's open `lib/app_web/controllers/item_html/new.html.heex`
and simplify it to just the essential field `:text`:

```elixir
<.simple_form :let={f} for={@changeset} action={~p"/items"}>
  <.input
    field={{f, :text}}
    type="text"
    placeholder="what needs to be done?"
  />
  <:actions>
    <.button style="display:none">Save Item</.button>
  </:actions>
</.simple_form>
```

> Before:
[`/lib/app_web/controllers/item_html/new.html.heex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/b158abd7f0c3fbc462a4230f07b5e5e79723a258/app/lib/app_web/controllers/item_html/new.html.heex) <br />
> After:
[`/lib/app_web/controllers/item_html/new.html.heex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8bcc3239d975f5b706514d1a88ea47ca57e5239a/lib/app_web/controllers/item_html/new.html.heex)

We need to additionally
change the style of the `<.input>` tag.
With Phoenix, inside the
`lib/app_web/components/core_components.ex` file,
the styles are defined for pre-built components
(which is the case with `<.input>`).

To change this so it uses the same style as TodoMVC,
locate the following line.

```elixir
def input(assigns) do
```

Change the class attribute
with the `new-todo` class.
This function should look like the following.

```elixir
  def input(assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <.label for={@id}><%= @label %></.label>
      <input
        type={@type}
        name={@name}
        id={@id || @name}
        value={@value}
        class={[
          input_border(@errors),
          "new-todo"
        ]}
        {@rest}
      />
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end
```

We also need to change the `actions` styles
inside the `simple_form`.
In the same file, search for `def simple_form(assigns) do`
and change it so it looks like so:

```elixir
  def simple_form(assigns) do
    ~H"""
    <.form :let={f} for={@for} as={@as} {@rest}>
      <div>
        <%= render_slot(@inner_block, f) %>
        <div :for={action <- @actions}>
          <%= render_slot(action, f) %>
        </div>
      </div>
    </.form>
    """
  end
```


If you run the Phoenix App now and visit
[http://localhost:4000/items/new](http://localhost:4000/items/new)
you will see the _single_ `:text` input field and no "Save" button:

![new-item-single-text-field-no-save-button](https://user-images.githubusercontent.com/17494745/205731473-4a9ce3b2-c902-4b66-9bdc-e64165f22841.png)

Don't worry, you can still submit the form with <kbd>Enter</kbd> (Return) key.
However if you attempt to submit the form now,
it won't work because we removed two of the fields required by the `changeset`!
Let's fix that.


### 5.1 Update the `items` Schema to Set `default` Values

Given that we have removed two of the fields (`:person_id` and `:status`)
from the `new.html.eex`,
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

In order to in-line the new item form (`new.html.eex`)
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


### 5.3 Render The `new.html.eex` inside `index.html.eex`

Now that we have done all the preparation work,
the next step is to render the `new.html.eex` (_partial_)
inside `index.html.eex` template.

Open the `lib/app_web/controllers/item_html/index.html.heex`
file and locate the line:

```html
<input class="new-todo" placeholder="What needs to be done?" autofocus="">
```

Replace it with this:

```elixir
<%= new(Map.put(assigns, :action, ~p"/items/new")) %>
```

Let's break down what we just did.
We are **embedding** the `new.html.heex` partial
inside the `index.html.heex` file.
We are doing this by calling the
`new/2` function inside `item_controller.ex`.
This function *pertains* to the page in the URL `items/new`
and renders the `new.html.heex` file.
Hence why we call this function to successfuly embed :smile:.

Before:
[`/lib/app_web/controllers/item_html/index.html.heex#L36`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/031df4076fc4ff84fd719a3a66c6dd2495268a50/lib/app_web/templates/item/index.html.eex#L36) <br />
After:
[`/lib/app_web/controllers/item_html/index.html.heex#L36`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3c04ee39df621cac200b4d3b45ad4045e67e388b/lib/app_web/controllers/item_html/index.html.heex#L30)



If you run the app now and visit:
[http://localhost:4000/items](http://localhost:4000/items) <br />
You can create an item by typing your text
and submit it with the <kbd>Enter</kbd> (Return) key.

<div align="center">

![todo-list-tutorial-step-5](https://user-images.githubusercontent.com/17494745/205904251-8c369d94-f3f9-43e9-b276-4b377e38cdc4.gif)

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
|> redirect(to: ~p"/items/#{item}")
```

Update the line to:

```elixir
|> redirect(to: ~p"/items/")
```

Before:
[`/lib/app_web/controllers/item_controller.ex#L22`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/8bcc3239d975f5b706514d1a88ea47ca57e5239a/lib/app_web/controllers/item_controller.ex#L23) <br />
After:
[`/lib/app_web/controllers/item_controller.ex#L23`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3c04ee39df621cac200b4d3b45ad4045e67e388b/lib/app_web/controllers/item_controller.ex#L23)

Now when we create a new `item`
we are redirected to the `index.html` template:

<div align="center">

![todo-list-tutorial-redirect-to-index](https://user-images.githubusercontent.com/17494745/205917351-5ccdeeed-0015-4bc5-9e67-9bd27f92f14e.gif)

</div>

### 5.5 Update `item_controller_test.exs` to Redirect to `index`

The changes we've made to the `new.html.heex` files 
and the steps above have broken some of our automated tests.
We ought to fix that.

Run the tests:

```sh
mix test
```

You will see the following output:

```
Finished in 0.08 seconds (0.03s async, 0.05s sync)
23 tests, 3 failures
```

Open the `test/app_web/controllers/item_controller_test.exs` file
and locate `describe "new item"` 
and `describe "create item"`.
Change these two to the following.

Replace the test:
```elixir
describe "new item" do
  test "renders form", %{conn: conn} do
    conn = get(conn, ~p"/items/new")
    assert html_response(conn, 200) =~ "what needs to be done?"
  end
end

describe "create item" do
  test "redirects to show when data is valid", %{conn: conn} do
    conn = post(conn, ~p"/items", item: @create_attrs)

    assert %{} = redirected_params(conn)
    assert redirected_to(conn) == ~p"/items/"
  end
end
```

> Updated code:
[`/test/app_web/controllers/item_controller_test.exs#L17-L31`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3c04ee39df621cac200b4d3b45ad4045e67e388b/test/app_web/controllers/item_controller_test.exs#L17-L31)

If you re-run the tests `mix test` the will now all pass again.

```sh
......................
Finished in 0.2 seconds (0.09s async, 0.1s sync)
22 tests, 0 failures
```

<br />

### 6. Display Count of Items in UI

So far the main functionality of the TodoMVC UI is working,
we can create new items and they appear in our list.
In this step we are going to enhance the UI to include
the count of remaining items in the bottom left corner.

Open the `test/app_web/controllers/item_html_test.exs` file
and create the following two tests:

```elixir
test "remaining_items/1 returns count of items where item.status==0" do
  items = [
    %{text: "one", status: 0},
    %{text: "two", status: 0},
    %{text: "done", status: 1}
  ]
  assert ItemHTML.remaining_items(items) == 2
end

test "remaining_items/1 returns 0 (zero) when no items are status==0" do
  items = []
  assert ItemHTML.remaining_items(items) == 0
end
```

e.g:
[`test/app_web/controllers/item_html_test.exs#L14-L26`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/32acb54881b8296fcd9cf39666f35b4761c54cb0/test/app_web/controllers/item_html_test.exs#L14-L26)

These tests will fail because the `ItemHTML.remaining_items/1`
function does not exist.

Make the tests _pass_ by adding the following code to
the `lib/app_web/controllers/item_html.ex` file:

```elixir
# returns integer value of items where item.status == 0 (not "done")
def remaining_items(items) do
  Enum.filter(items, fn i -> i.status == 0 end) |> Enum.count
end
```

e.g:
[`/lib/app_web/controllers/item_html#L15-L17`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_html.ex#L15-L17)

Now that the tests are passing,
_use_ the `remaining_items/1` in the `index.html` template.
Open the `lib/app_web/controllers/item_html/index.html.eex` file
and locate the line of code:

```html
<span class="todo-count"><strong>1</strong> item left</span>
```

Replace it with this line:
```html
<span class="todo-count"><%= remaining_items(@items) %> items left</span>
```

This just invokes the `ItemHTML.remaining_items/1` function
with the List of `@items` which will return the integer count
of remaining items that have not yet been "done".

E.g:
[`/lib/app_web/controllers/item_html/index.html.eex#L60`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/32acb54881b8296fcd9cf39666f35b4761c54cb0/lib/app_web/controllers/item_html/index.html.heex#L60)


At this point the (remaining) items counter
in the bottom left of the TodoMVC UI is _working_! <br />
Add a `new` item to your list and watch the count increase:

![item-count-increases-to-2](https://user-images.githubusercontent.com/17494745/205924061-36d9bd5a-7884-4ca7-8237-669a97a73e75.gif)

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

Open the `test/app_web/controllers/item_controller_test.exs` file.
We are going to make some changes here
so we can add tests to the functions we
mentioned prior.
We are going to import `App.Todo` 
inside `item_controller_test.exs` 
and fix create and attribute constants 
to create mock items.
Make sure the beginning of the 
file looks like so.

```elixir
defmodule AppWeb.ItemControllerTest do
  use AppWeb.ConnCase
  alias App.Todo

  import App.TodoFixtures

  @create_attrs %{person_id: 42, status: 0, text: "some text"}
  @update_attrs %{person_id: 43, status: 1, text: "some updated text"}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}
```

After this, locate `defp create_item()/1`
function inside the same file. 
Change it so it looks like so.

```elixir
  defp create_item(_) do
    item = item_fixture(@create_attrs)
    %{item: item}
  end
```

We are going to be using this function
to create `Item` objects 
to use in the tests we are going to add.
Speaking of which, let's do that!
Add the following snippet to the file.

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
    get(conn, ~p'/items/toggle/#{item.id}')
    toggled_item = Todo.get_item!(item.id)
    assert toggled_item.status == 1
  end
end
```

e.g:
[`/test/app_web/controllers/item_controller_test.exs#L64-L82`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/test/app_web/controllers/item_controller_test.exs#L64-L82)

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
    conn
    |> redirect(to: ~p"/items")
  end
```

e.g:
[`/lib/app_web/controllers/item_controller.ex#L64-L76`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bbaa6cad585bff76602e7f3cea6a43b8a1f08cbb/lib/app_web/controllers/item_controller.ex#L64-L76)

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
[`/lib/app_web/router.ex#L21`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/bbaa6cad585bff76602e7f3cea6a43b8a1f08cbb/lib/app_web/router.ex#L21)

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
Open the `/lib/app_web/controllers/item_html/index.html.heex` file
and locate the line:

```html
<%= if item.status == 1 do %>
...
<% else %>
...
<% end %>
```

Replace it with the following:

```html
  <%= if item.status == 1 do %>
    <.link href={~p"/items/toggle/#{item.id}"}
        class="toggle checked">
        type="checkbox"
    </.link>
  <% else %>
    <.link href={~p"/items/toggle/#{item.id}"}
        type="checkbox"
        class="toggle">
    </.link>
  <% end %>
```

When this link is clicked
the `get /items/toggle/:id` endpoint is invoked, <br />
that in turn triggers the `toggle/2` handler
we defined above.


> Before:
[`/lib/app_web/controllers/item_html/index.html.heex#L40`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/32acb54881b8296fcd9cf39666f35b4761c54cb0/lib/app_web/controllers/item_html/index.html.heex#L40) <br />
> After:
[`/lib/app_web/controllers/item_html/index.html.heex#L47-L57`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3329d8f2272d01641ed74c6b10adc957821bc81f/lib/app_web/controllers/item_html/index.html.heex#L47-L57)



### 7.5 Add a `.checked` CSS to `app.scss`


Unfortunately, `<a>` tags (that are generated with `<.link>`)
cannot have a `:checked` pseudo selector,
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
[`/assets/css/app.scss#L8`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/assets/css/app.css#L8)

And when you view the app,
the Toggle functionality is working as expected:

![todo-app-toggle](https://user-images.githubusercontent.com/17494745/205961019-141d4488-3856-4c1e-b846-6ef52252c7d1.gif)


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

### 7.6 Maintaining correct order of `todo` items

If you "complete" or revert the operation,
the order of the todos might differ between
these operations.
To keep this consistent, 
let's fetch all the `todo` items in the same order.

Inside `lib/app/todo.ex`, 
change `list_items/0` to the following.

```elixir
  def list_items do
    query =
      from(
        i in Item,
        select: i,
        order_by: [asc: i.id]
      )

    Repo.all(query)
  end
```

By fetching the `todo` items and ordering them,
we guarantee the UX stays consistent! 


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
`lib/app_web/controllers/item_html/index.html.heex`
file and locate the line:

```elixir
<%= new(Map.put(assigns, :action, ~p"/items/new")) %>
```

Replace it with:

```elixir
<%= if @editing.id do %>
  <.link href={~p"/items"}
      method="get"
      class="new-todo">
      Click here to create a new item!
  </.link>
<% else %>
  <%= new(Map.put(assigns, :action, ~p"/items/new")) %>
<% end %>
```

In here, we are checking if we are editing an item,
and rendering a link instead of the form.
We do this to avoid having multiple forms on the page.
If we are _not_ editing an item,
render the `new.html.heex` as before.
With this, if the user is editing an item,
he is able to "get out of editing mode"
by clicking on the link that is rendered.

e.g:
[`lib/app_web/controllers/item_html/index.html.heex#L30-L38`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3329d8f2272d01641ed74c6b10adc957821bc81f/lib/app_web/controllers/item_html/index.html.heex#L30-L38)

Next, still in the `index.html.eex` file,
locate the line:

```html
<%= for item <- @items do %>
```

Replace the entire `<li>` tag
with the following code.

```elixir
<li data-id={item.id} class={complete(item)}>
    <%= if item.status == 1 do %>
      <.link href={~p"/items/toggle/#{item.id}"}
          class="toggle checked">
          type="checkbox"
      </.link>
    <% else %>
      <.link href={~p"/items/toggle/#{item.id}"}
          type="checkbox"
          class="toggle">
      </.link>
    <% end %>

  <div class="view">
    <%= if item.id == @editing.id do %>
      <%= edit(
        Map.put(assigns, :action, ~p"/items/#{item.id}/edit")
        |> Map.put(:item, item)
      ) %>
    <% else %>
      <.link href={~p"/items/#{item}/edit"} class="dblclick">
        <label><%= item.text %></label>
      </.link>
      <span></span> <!-- used for CSS Double Click -->
    <% end %>

    <.link
      class="destroy"
      href={~p"/items/#{item}"}
      method="delete"
    >
    </.link>
  </div>
</li>
```

e.g:
[`lib/app_web/controllers/item_html/index.html.heex#L46-L79`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3329d8f2272d01641ed74c6b10adc957821bc81f/lib/app_web/controllers/item_html/index.html.heex#L46-L79)

We have done a few things here.
We changed the toggle button outside the 
`<div class="view>` tag.
Additionally, we have changed the text
with a `if else` block statements.

If the user is not editing,
a link (`<a>`) is rendered which, 
when clicked, allows the user to enter "edit" mode.
On the other hand, if the user *is editing*,
it renders the `edit.html.heex` file.

Speaking of which, let's edit `edit.html.heex`
so it renders what we want:
a text field that, once `Enter` is pressed,
edits the referring todo item.

```html
<.simple_form :let={f} for={@changeset} method="put" action={~p"/items/#{@item}"}>
  <.input
    field={{f, :text}}
    type="text"
    placeholder="what needs to be done?"
    class="new-todo"
  />
  <:actions>
    <.button
    style="display: none;"
    type="submit">
      Save
    </.button>
  </:actions>
  <!-- submit the form using the Return/Enter key -->
</.simple_form>
```

<br />

### 8.2 Update `CSS` For Editing

To enable the CSS double-click effect
to enter `edit` mode,
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
[`assets/css/app.css#L13-L32`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/assets/css/app.css#L13-L32)


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
[`assets/css/app.css#L34-L71`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/assets/css/app.css#L34-L71)

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

Finally, we need to handle the form submission
to update an item (that is rendered in `edit.html.heex`).
When we press `Enter`, the `update/2` handler is called
inside `lib/app_web/controllers/item_controller.ex`.
We want to stay on the same page after updating the item.

So,change it so it looks like this.

```elixir
def update(conn, %{"id" => id, "item" => item_params}) do
  item = Todo.get_item!(id)

  case Todo.update_item(item, item_params) do
    {:ok, _item} ->
      conn
      |> redirect(to: ~p"/items/")

    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, :edit, item: item, changeset: changeset)
  end
end
```

Your `item_controller.ex` file should now look like this:
[`lib/app_web/controllers/item_controller.ex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3329d8f2272d01641ed74c6b10adc957821bc81f/lib/app_web/controllers/item_controller.ex)

<br />

### 8.4 Update the Tests in `ItemControllerTest`

In our quest to build a _Single_ Page App,
we broke a few tests! That's OK. 
They're easy to fix.

Open the `test/app_web/controllers/item_controller_test.exs`
file and cocate the test with the following text.

`test "renders form for editing chosen item"`

and change it so it looks like the following.

```elixir
  test "renders form for editing chosen item", %{conn: conn, item: item} do
    conn = get(conn, ~p"/items/#{item}/edit")
    assert html_response(conn, 200) =~ "Click here to create a new item"
  end
```

When we enter the "edit timer mode",
we create `<a>` a link to return to `/items`,
as we have previously implemented.
This tag has the "Click here to create a new item" text,
which is what we are asserting.

e.g:
[`test/app_web/controllers/item_controller_test.exs#L37-L39`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3d5d839d6053c3f6ac5140459a4c3c010d45b195/test/app_web/controllers/item_controller_test.exs#L37-L39)


Next, locate the test with the following description:

```elixir
describe "update item"
```

Update the block to the following
piece of code.

```elixir
describe "update item" do
  setup [:create_item]

  test "redirects when data is valid", %{conn: conn, item: item} do
    conn = put(conn, ~p"/items/#{item}", item: @update_attrs)
    assert redirected_to(conn) == ~p"/items/"

    conn = get(conn, ~p"/items/")
    assert html_response(conn, 200) =~ "some updated text"
  end
end
```

e.g:
[`test/app_web/controllers/item_controller_test.exs#L43-L53`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3d5d839d6053c3f6ac5140459a4c3c010d45b195/test/app_web/controllers/item_controller_test.exs#L43-L53)

We've updated the paths the application redirects to
after updating an item. 
Since we are building a single-page application,
that path pertains to the `/items/` URL path.

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
from the `lib/app_web/controllers/item_html/index.html.heex` template.

<img width="872" alt="phoenix-todo-list-table-layout" src="https://user-images.githubusercontent.com/194400/83200932-54245b80-a13c-11ea-92a3-6b55fc2b2652.png">

Open the `lib/app_web/controllers/item_html/index.html.eex` file
and remove all code before the line:
```html
<section class="todoapp">
```

e.g:
[`lib/app_web/controllers/item_html/index.html.heex`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3d5d839d6053c3f6ac5140459a4c3c010d45b195/lib/app_web/controllers/item_html/index.html.heex)

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
[`test/app_web/controllers/item_controller_test.exs#L14`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/3d5d839d6053c3f6ac5140459a4c3c010d45b195/test/app_web/controllers/item_controller_test.exs#L14)

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
get "/items/:filter", ItemController, :index
```

e.g:
[`/lib/app_web/router.ex#L23`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/router.ex#L23)

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
[`lib/app_web/controllers/item_controller.ex#L17-L22`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_controller.ex#L17-L22)

`Map.get(params, "filter", "all")`
sets the default value of our `filter` to "all"
so when `index.html` is rendered, show "all" items.

<br />

### 9.3 Create `filter/2` View Function

In order to filter the items by their status,
we need to create a new function. <br />
Open the `lib/app_web/controllers/item_html.ex` file
and create the `filter/2` function as follows:

```elixir
def filter(items, str) do
  case str do
    "items" -> items
    "active" -> Enum.filter(items, fn i -> i.status == 0 end)
    "completed" -> Enum.filter(items, fn i -> i.status == 1 end)
    _ -> items
  end
end
```

e.g:
[`lib/app_web/controllers/item_html.ex#L19-L26`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/50cce48a72d27b52cfeae158e3191e3cd1a8fe87/lib/app_web/controllers/item_html.ex#L19-L26)

This will allow us to filter the items in the next step.

<br />

### 9.4 Update the Footer in the `index.html` Template

Use the `filter/2` function to filter the items that are displayed.
Open the `lib/app_web/controllers/item_html/index.html.heex` file
and locate the `for` loop line:

```elixir
<%= for item <- @items do %>
```

Replace it with:

```elixir
<%= for item <- filter(@items, @filter) do %>
```
e.g:
[`lib/app_web/controllers/item_html/index.html.heex#L18`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/50cce48a72d27b52cfeae158e3191e3cd1a8fe87/lib/app_web/controllers/item_html/index.html.heex#L18)

This invokes the `filter/2` function we defined in the previous step
passing in the list of `@items` and the selected `@filter`.


Next, locate the the `<footer>`
and replace the _contents_
of the
`<ul class="filters">`
with the following code:

```elixir
  <li>
    <%= if @filter == "items" do %>
      <a href="/items" class='selected'>
        All
      </a>
    <% else %>
      <a href="/items">
        All
      </a>
    <% end %>
  </li>
  <li>
    <%= if @filter == "active" do %>
      <a href="/items/active" class='selected'>
        Active
        [<%= Enum.count(filter(@items, "active")) %>]
      </a>
    <% else %>
      <a href="/items/active">
        Active
        [<%= Enum.count(filter(@items, "active")) %>]
      </a>
    <% end %>
  </li>
  <li>
    <%= if @filter == "completed" do %>
      <a href="/items/completed" class='selected'>
        Completed
        [<%= Enum.count(filter(@items, "completed")) %>]
      </a>
    <% else %>
      <a href="/items/completed">
        Completed
        [<%= Enum.count(filter(@items, "completed")) %>]
      </a>
    <% end %>
  </li>
```

We are conditionally adding the `selected` class
according to the `@filter` assign value. 

e.g:
[`/lib/app_web/controllers/item_html/index.html.heex#L62-L98`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/50cce48a72d27b52cfeae158e3191e3cd1a8fe87/lib/app_web/controllers/item_html/index.html.heex#L62-L98)

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
get "/items/clear", ItemController, :clear_completed
```

Your `scope "/"` should now look like the following:

```elixir
  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/items/toggle/:id", ItemController, :toggle
    get "/items/clear", ItemController, :clear_completed
    get "/items/:filter", ItemController, :index
    resources "/items", ItemController
  end
```

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
[`lib/app_web/controllers/item_controller.ex#L87-L93`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_controller.ex#L87-L93)

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


Finally, in the `lib/app_web/controllers/item_html/index.html.eex`
scroll to the bottom of the file and replace the line:

```elixir
<button class="clear-completed" style="display: block;">
  Clear completed
</button>
```

With:

```elixir
<a class="clear-completed" href="/items/clear">
  Clear completed
  [<%= Enum.count(filter(@items, "completed")) %>]
</a>
```

e.g:
[`lib/app_web/controllers/item_html/index.html.heex#L104-L107`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_html/index.html.heex#L104-L107)

The last thing we need to do is to 
update the `filter/2` function 
inside `lib/app_web/controllers/item_html.ex`.
Since `status = 2` now pertains to an **archived** state,
we want to return anything that is not archived.

Change the `filter/2` function so it looks like so.

```elixir
def filter(items, str) do
  case str do
    "items" -> Enum.filter(items, fn i -> i.status !== 2 end)
    "active" -> Enum.filter(items, fn i -> i.status == 0 end)
    "completed" -> Enum.filter(items, fn i -> i.status == 1 end)
    _ -> Enum.filter(items, fn i -> i.status !== 2 end)
  end
end
```

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

Open your `test/app_web/controllers/item_html_test.exs` file
and add the following test:

```elixir
test "pluralise/1 returns item for 1 item and items for < 1 <" do
  assert ItemHTML.pluralise([%{text: "one", status: 0}]) == "item"
  assert ItemHTML.pluralise([
    %{text: "one", status: 0},
    %{text: "two", status: 0}
  ]) == "items"
  assert ItemHTML.pluralise([%{text: "one", status: 1}]) == "items"
end
```

e.g:
[`test/app_web/controllers/item_html_test.exs#L28-L35`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/test/app_web/controllers/item_html_test.exs#L28-L35)


This test will obviously fail because the
`AppWeb.ItemHTML.pluralise/1` is undefined.
Let's make it pass!

Open your `lib/app_web/controllers/item_html.ex` file
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
[`lib/app_web/controllers/item_html.ex#L28-L35`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_html.ex#L28-L35)

> **Note**: we are only pluralising one word in our basic Todo App
so we are only handling this one case in our `pluralise/1` function.
In a more advanced app we would use a translation tool
to do this kind of pluralising.
See: https://hexdocs.pm/gettext/Gettext.Plural.html

Finally, _use_ the `pluralise/1` in our template.
Open `lib/app_web/controllers/item_html/index.html.heex`

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
[`lib/app_web/controllers/item_html/index.html.heex#L61`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/6649a67639ccf7ad1b3189aefe678e3621a08341/lib/app_web/controllers/item_html/index.html.heex#L61)

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

Open your `lib/app_web/controllers/item_html.ex` file
and add the following function definition `unarchived_items/1`:

```elixir
def got_items?(items) do
  Enum.filter(items, fn i -> i.status < 2 end) |> Enum.count > 0
end
```

e.g:
[`lib/app_web/controllers/item_html.ex#L37-L39`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_html.ex#L37-L39)


Now _use_ `got_items?/1` in the template.

Wrap the `<footer>` element in the following `if` statement:

```elixir
<%= if got_items?(@items) do %>

<% end %>
```

e.g:
[`lib/app_web/controllers/item_html/index.html.heex#L58`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/controllers/item_html/index.html.heex#L58)


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
they see the `lib/app_web/controllers/page_html/home.html.eex` template:

![page_template](https://user-images.githubusercontent.com/17494745/206484573-3596814d-92ce-42a0-9817-30fc16ce74cc.png)

This is the default Phoenix home page
(_minus the CSS Styles and images that we removed in step 3.4 above_).
It does not tell us anything about the actual app we have built,
it doesn't even have a _link_ to the Todo App!
Let's fix it!

Open the `lib/app_web/router.ex` file and locate the line:
```elixir
get "/", PageController, :index
```

Update the controller to `ItemController`.

```elixir
get "/", ItemController, :index
```

e.g:
[`lib/app_web/router.ex#L20`](https://github.com/dwyl/phoenix-todo-list-tutorial/blob/a341c2cbb5f1ad91897293f058a5d7bee6c1e1cc/lib/app_web/router.ex#L20)

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
git rm lib/app_web/controllers/page_html.ex
git rm lib/app_web/page_html/home.html.heex
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
**[Turbo](https://github.com/hotwired/turbo)**!

Get the performance benefits of an SPA
without the added complexity
of a client-side JavaScript framework.
When a link is clicked/tapped,
Turbolinks automatically fetches the page,
swaps in its `<body>`, and merges its `<head>`,
all without incurring the cost of a full page load.


Luckily, adding `Turbo` will require just a simple
copy and paste!
Check the [`unpkg files`](https://unpkg.com/browse/@hotwired/turbo@7.2.4/dist/) 
to fetch the latest CDN package.

We now need to add the following line
to `lib/app_web/components/layouts/app.html.heex`
and `lib/app_web/components/layouts/root.html.heex`.

```html
  <script src="https://unpkg.com/browse/@hotwired/turbo@7.2.4/dist/turbo.es2017-esm.js"></script>
```

This will install the UMD builds from Turbo
without us needing to install a package using `npm`.
Neat, huh?

And that's it!
Now when you deploy your server rendered Phoenix App,
it will _feel_ like an SPA!
Try the Fly.io demo again:
[phxtodo.fly.dev](https://phxtodo.fly.dev/)
Feel that buttery-smooth page transition.


<br />
### Deploy!

Deployment to Fly.io takes a few minutes,
but has a few "steps",
we suggest you follow the speed run guide:
https://fly.io/docs/elixir/getting-started/

Once you have _deployed_ you will will be able
to view/use your app in any Web/Mobile Browser.

e.g: https://phxtodo.fly.dev <br />xs

![phxtodo-fly-io](https://user-images.githubusercontent.com/194400/206772309-77056109-8e60-40ad-8e16-4e0f3140c0eb.png)


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


## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
  + Phoenix Chat Tutorial:
  https://github.com/dwyl/phoenix-chat-example
  + Phoenix LiveView Counter Tutorial:
  https://github.com/dwyl/phoenix-liveview-counter-tutorial
