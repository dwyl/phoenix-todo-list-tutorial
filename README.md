<div align="center">

# `Phoenix` Todo List Tutorial!

A complete beginners tutorial building a Todo List in Phoenix.

[![Build Status](https://img.shields.io/travis/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](https://travis-ci.org/dwyl/phoenix-todo-list-tutorial)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/phoenix-todo-list-tutorial/master.svg?style=flat-square)](http://codecov.io/github/dwyl/phoenix-todo-list-tutorial?branch=master)
<!-- [![HitCount](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial.svg)](http://hits.dwyl.com/dwyl/phoenix-todo-list-tutorial) -->

</div>
<br />


## Why? 🤷‍

Todo lists are familiar to most people. <br />
_Building_ a Todo list from scratch is a great way to learn Phoenix.

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

Install dependencies ad setup the database:

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

Visit
[`localhost:4000`](http://localhost:4000)
in your web browser.

You should see:

# TODO: add screenshot of todo list home page


Now that you have the _finished_ example app
running on your localhost,
let's build it from scratch
and understand all the steps.



### 1. Create a Phoenix Project 🆕

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

![phoenix-default-homepage](https://user-images.githubusercontent.com/194400/74361992-c2c4ef80-4dbf-11ea-8112-2dcf6dcf1c51.png)

Also make sure you run the tests to ensure everything works as expected:

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

Having established that your Phoenix App works as expected,
let's dive into the fun part!






## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
+ Learn Vagrant: https://github.com/dwyl/learn-vagrant
