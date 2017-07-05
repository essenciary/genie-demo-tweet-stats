module CreateTableSearches

using SearchLight

function up()
  SearchLight.query("
    CREATE TABLE searches (
      id          INTEGER PRIMARY KEY,
      search      VARCHAR(50) UNIQUE
    )
  ")
  SearchLight.query("CREATE INDEX searches__idx_search ON searches (search)")
end

function down()
  SearchLight.query("DROP TABLE searches")
end

end
