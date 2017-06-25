module CreateTableSearches

using SearchLight

function up()
  SearchLight.query("CREATE SEQUENCE searches__seq_id")
  SearchLight.query("
    CREATE TABLE searches (
      id          INTEGER CONSTRAINT searches__idx_id PRIMARY KEY DEFAULT NEXTVAL('searches__seq_id'),
      search      VARCHAR(50) UNIQUE
    )
  ")
  SearchLight.query("ALTER SEQUENCE searches__seq_id OWNED BY searches.id")
  SearchLight.query("CREATE INDEX searches__idx_search ON searches (search)")
end

function down()
  SearchLight.query("DROP TABLE searches")
end

end
