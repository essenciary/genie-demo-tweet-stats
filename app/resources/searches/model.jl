export Search, Searches

type Search <: AbstractModel
  ### internals
  _table_name::String
  _id::String

  ### fields
  id::Nullable{SearchLight.DbId}
  search::String

  ### constructor
  Search(;
    id = Nullable{SearchLight.DbId}(),
    search = ""
  ) = new("searches", "id", id, search)
end

module Searches
using App
end
