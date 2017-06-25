module ImportTweetsTask

using Genie, Twitter, SearchLight, App, Toolbox, Logger, SentimentAnalysis, Channels

function description()
  """
  Imports a new batch of tips from the Twitter API
  """
end

function run_task!() :: TaskResult
  while true
    for search in SearchLight.find(Search)
      if haskey(Channels.SUBSCRIPTIONS, "tweets-" * search.search)
        import_tweets("#" * search.search)
      end
    end

    sleep(.5)
  end

  VoidTaskResult()
end

function import_tweets(search_hash)
  latest_tweet = SearchLight.find(Tweet, SQLQuery(order = "id DESC", limit = 1))
  latest_tweet_id = isempty(latest_tweet) ? "1" : first(latest_tweet).tweet_id

  for tweet in tweets(search_hash, latest_tweet_id)
    t = App.Tweet(tweet_id = tweet.id_str,
                  text = tweet.full_text,
                  user_name = tweet.user["name"],
                  screen_name = tweet.user["screen_name"],
                  avatar_url = tweet.user["profile_image_url"],
                  favorite_count = tweet.favorite_count,
                  retweet_count = tweet.retweet_count)

    sentiment = SentimentAnalysis.analyze(t.text)
    t.polarity = sentiment.polarity
    t.subjective = sentiment.subjective
    t.search_hash = search_hash[2:end]

    SearchLight.create_or_update_by!!(t, :tweet_id)

    sleep(.5)
  end
end

function tweets(hash, latest_tweet_id)
  get_search_tweets(hash, options = Dict("tweet_mode" => "extended", "result_type" => "recent", "lang" => "en", "since_id" => latest_tweet_id))
end

end
