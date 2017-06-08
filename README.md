# Api

The dwyl REST &amp; WebSocket API.

![perfection-intro-image](https://cloud.githubusercontent.com/assets/194400/8255483/2fc78e6c-1698-11e5-8c27-d1b9db99f020.png)

## Why?

Separating the "backend" of our application from any UI
so that we can use it for both the Web and Mobile/Native apps.

## What?

A "high performance" REST & WebSocket API
that can be accessed from anywhere.

<!--
## Who?

Anyone building an app for the @dwyl platform.
Or, anyone who want's their own easy to deploy/scale "backend".
-->

## How?

> The API is built using using the Phoenix Web Framework.
If you are `new` to Elixir or Phoenix please
see the Learning section below.

### Try It! (Heroku)

Visit: https://dwylapi.herokuapp.com/rows

Create a new Person (User)
```
curl -H "Content-Type: application/json" -X POST -d '{"person": {"name":"Simon","email":"simon@dwyl.io"}}' https://dwylapi.herokuapp.com/people
```

Now create a Row (record):
```
curl -H "Content-Type: application/json" -X POST -d '{"rows": {"id":1, "title":"Simon Says Hi!","body":"This is my amazing post!", "people_id":"2"}}' https://dwylapi.herokuapp.com/rows
```
You should see your record when you visit:
https://dwylapi.herokuapp.com/rows


### localhost

Create a new Person (User)
```
curl -H "Content-Type: application/json" -X POST -d '{"person": {"name":"Simon","email":"simon@dwyl.io"}}' http://localhost:4000/people
```

Now create a Row (record):
```
curl -H "Content-Type: application/json" -X POST -d '{"rows": {"id":1, "title":"Simon Says Hi!","body":"This is my amazing post!", "people_id":"22"}}' http://localhost:4000/rows
```

/register a new person
```
```
curl -H "Content-Type: application/json" -X POST -d '{"person": {"name":"Simon","email":"simon@dwyl.io"}}' http://localhost:4000/register
```


## *Required* Environment Variables

The API server will *not* work unless these
environment variables are set.

Copy-paste the following set commands to set up
the Env Variables on your local machine:
```sh
export DATABASE_URL=postgres://postgres:@localhost/api_dev
export SECRET_KEY_BASE=TotesMcSafeSuperLongStringOfRandomCharactersSnNW25bz7s1izRtn06DswDoZEKecCqeCgryjPs
export AWS_API_SECRET='AskUsForTheKey!'
```

To start your Phoenix app:

+ Install dependencies with `mix deps.get`
+ Create and migrate your database with `mix ecto.create && mix ecto.migrate`
+ (_Optionally_) Seed the database with dummy data: `mix run priv/repo/seeds.exs`
+ Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/rows`](http://localhost:4000/rows) from your browser.

<!--

## Send Welcome Email

### Local

```sh
curl --data "email=dwyl.smith+1234@gmail.com" http://localhost:8000/email
```

### heroku

```
curl --data "email=dwyl.smith+1234@gmail.com" https://dwylapi.herokuapp.com/email
```

-->

## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
+ Learn Vagrant: https://github.com/dwyl/learn-vagrant


## GraphQL

Now you can visit http://localhost:4000/graphiql from your browser.

Run the following GraphQL Query:
```
{
  blogPosts {
    title,
    id
  }
}
```
e.g:
![image](https://user-images.githubusercontent.com/194400/26842137-afebee5e-4ae3-11e7-9fbc-97f805778a43.png)
