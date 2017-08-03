module CreateTableSearches

import Migration: create_sequence, create_table, column_id, column,
                  column_id_sequence, add_index, drop_table, drop_sequence,
                  constraint, nextval

function up()
  create_sequence(:searches, :id)
  create_table(:searches) do
    [
      column_id(constraint = constraint(:searches, :id), nextval = nextval(:searches, :id))
      column(:search, :string, limit = 50)
    ]
  end
  column_id_sequence(:searches, :id)
  add_index(:searches, :search)
end

function down()
  drop_table(:searches)
end

end
