## Steps to Reproduce

mix phx.new api --no-html --no-brunch

cd api
mix ecto.create


mix phx.gen.json People Person people name:string email:string

Add the resource to your :api scope in lib/api/web/router.ex:

	resources "/people", PersonController, except: [:new, :edit]


Remember to update your repository by running migrations:

    $ mix ecto.migrate

mix phx.gen.json Content Rows rows title:string body:text people_id:references:people

Add the resource to your :api scope in lib/api/web/router.ex:

    resources "/rows", RowsController, except: [:new, :edit]


Remember to update your repository by running migrations:

    $ mix ecto.migrate
