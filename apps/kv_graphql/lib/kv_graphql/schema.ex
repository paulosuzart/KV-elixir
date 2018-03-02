defmodule KVGraphQL.Schema do
  use Absinthe.Schema
  require KVServer.Command

  import_types Absinthe.Type.Custom
  import_types KVGraphQL.Schema.Bucket

  mutation do

    @desc "Deletes a given key from a bucket"
    field :delete, type: :boolean do
      arg :bucket, non_null(:string)
      arg :key, non_null(:string)

      resolve fn %{bucket: bucket, key: key}, _ ->
        case KVServer.Command.run({:delete, bucket, key}) do
          {:ok, _} -> {:ok, true}
          {:error, :not_found} -> {:error, "Not Found"}
        end
      end

    end


    @desc "Creates a new bucket with a given name"
    field :create, type: :boolean do
      arg :bucket, non_null(:string)

      resolve fn %{bucket: bucket}, _ ->
        case KVServer.Command.run({:create, bucket}) do
          {:ok, _} -> {:ok, true}
          _ -> {:error, "Unknown Error"}
        end
      end
    end


    @desc "Puts a value into a bucket under a certain key"
    field :put, type: :boolean do
      arg :bucket, non_null(:string)
      arg :key, non_null(:string)
      arg :value, non_null(:string)

      resolve fn %{bucket: bucket, key: key, value: value}, _ ->
        case KVServer.Command.run({:put, bucket, key, value}) do
          {:ok, _} -> {:ok, true}
          _ -> {:error, "Not Found"}
        end
      end
    end
  end


  query do

    @desc "Get entry from given bucket and key"
    field :get, :bucket_entry do
      arg :bucket, non_null(:string)
      arg :key, non_null(:string)

      resolve fn %{bucket: bucket, key: key}, _ ->
        case KVServer.Command.run({:get, bucket, key}) do
          {:ok, value} -> {:ok, %{key: key, value: String.replace(value, "\r\nOK\r\n", "")}}
          _ -> {:error, "Not Found"}
        end
      end
    end

  end
end
