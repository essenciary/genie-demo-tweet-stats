module CreateTableTweets

import Migration: create_sequence, create_table, column_id, column,
                  column_id_sequence, add_index, drop_table, drop_sequence,
                  constraint, nextval

function up()
  create_sequence(:tweets, :id)
  create_table(:tweets) do
    [
      column_id(constraint = constraint(:tweets, :id), nextval = nextval(:tweets, :id))
      column(:tweet_id, :string, limit = 24)
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
  column_id_sequence(:tweets, :id)

  add_index(:tweets, :tweet_id, unique = true)
  add_index(:tweets, :text)
  add_index(:tweets, :polarity)
  add_index(:tweets, :subjective)
end

function down()
  drop_table(:tweets)
end

end
