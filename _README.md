# Api

The dwyl REST &amp; WebSocket API.

![perfection-intro-image](https://cloud.githubusercontent.com/assets/194400/8255483/2fc78e6c-1698-11e5-8c27-d1b9db99f020.png)

## How?

> The API is built using using the Phoenix Web Framework.
If you are `new` to Elixir or Phoenix please
see the Learning section below.



## *Required* Environment Variables

The API server will *not* work unless these
environment variables are set.

Run the following command to set up your local machine:
```sh
export AWS_API_SECRET='AskUsForTheKey!'
```

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Send Welcome Email

### Local

```sh
curl --data "email=dwyl.smith+1234@gmail.com" http://localhost:1337/email
```

### heroku

```
curl --data "email=dwyl.smith+1234@gmail.com" https://dwylapi.herokuapp.com/email
```


## Learning

+ Learn Elixir: https://github.com/dwyl/learn-elixir
+ Learn Phoenix https://github.com/dwyl/learn-phoenix-framework
+ Learn Vagrant: https://github.com/dwyl/learn-vagrant
