module CreateTableSearches

import Migration: create_table, column, column_id, add_index, drop_table

function up()
  create_table(:searches) do
    [
      column_id()
      column(:search, :string, limit = 50)
    ]
  end

  add_index(:searches, :search, unique = true)
end

function down()
  drop_table(:searches)
end

end
