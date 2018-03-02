# KvUmbrella

Modified version of Elixir tutorial of a Distributed KV-Store to expose a GraphQL interface.

## Running it

Start two nodes like this:

```
PORT=4040 iex --sname foo -S mix
PORT=4041 iex --sname bar -S mix
```