module CreateTableTweets

import Migration: create_table, column, column_id, add_index, drop_table

function up()
  create_table(:tweets) do
    [
      column_id()
      column(:tweet_id, :string, "UNIQUE", limit = 24)
      column(:text, :string, limit = 512)
      column(:user_name, :string, limit = 32)
      column(:screen_name, :string, limit = 32)
      column(:avatar_url, :string, limit = 512)
      column(:favorite_count, :integer)
      column(:retweet_count, :integer)
      column(:polarity, :integer)
      column(:subjective, :boolean)
    ]
  end

  add_index(:tweets, :tweet_id, unique = true)
  add_index(:tweets, :text)
  add_index(:tweets, :polarity)
  add_index(:tweets, :subjective)
end

function down()
  drop_table(:tweets)
end

end
