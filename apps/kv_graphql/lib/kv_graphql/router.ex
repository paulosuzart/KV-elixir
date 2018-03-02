defmodule KVGraphQL.Router do
  use Plug.Router

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Poison)

  
   plug :match
   plug :dispatch
  
  forward "/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: KVGraphQL.Schema,
      interface: :playground,
    ]
 

  forward "/graphql",
    to: Absinthe.Plug,
    init_opts: [schema: KVGraphQL.Schema]
  
   get("/", do: send_resp(conn, 200, "Welcome"))
   match(_, do: send_resp(conn, 404, "Oops!"))
end
