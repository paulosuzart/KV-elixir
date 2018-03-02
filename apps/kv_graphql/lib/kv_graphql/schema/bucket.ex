defmodule KVGraphQL.Schema.Bucket do
  use Absinthe.Schema.Notation

  @desc "Bucket"
  object :bucket do
    field :name, :string
    field :entries, list_of(:bucket_entry)
  end
  
  @desc "Entry"
  object :bucket_entry do
    field :key, :string
    field :value, :string
  end
end
