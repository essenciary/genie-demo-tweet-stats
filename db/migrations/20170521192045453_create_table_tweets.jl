module CreateTableTweets

using Genie, SearchLight

function up()
  SearchLight.query("
    CREATE TABLE tweets (
      id              INTEGER PRIMARY KEY,
      tweet_id        VARCHAR(24) UNIQUE,
      text            VARCHAR(512),
      user_name       VARCHAR(32),
      screen_name     VARCHAR(32),
      avatar_url      VARCHAR(512),
      favorite_count  INTEGER,
      retweet_count   INTEGER,
      polarity        INTEGER,
      subjective      BOOLEAN
    )
  ")
  SearchLight.query("CREATE INDEX tweets__idx_tweet_id ON tweets (id)")
  SearchLight.query("CREATE INDEX tweets__idx_text ON tweets (text)")
  SearchLight.query("CREATE INDEX tweets__idx_polarity ON tweets (polarity)")
  SearchLight.query("CREATE INDEX tweets__idx_subjective ON tweets (subjective)")
end

function down()
  SearchLight.query("DROP TABLE tweets")
end

end
