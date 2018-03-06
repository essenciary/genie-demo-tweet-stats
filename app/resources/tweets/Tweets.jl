module Tweets

using App, SearchLight

export Tweet

using Channels

mutable struct Tweet <: AbstractModel
  ### internals
  _table_name::String
  _id::String

  ### fields
  id::Nullable{SearchLight.DbId}
  tweet_id::String
  text::String
  user_name::String
  screen_name::String
  avatar_url::String
  favorite_count::Int
  retweet_count::Int
  polarity::Int
  subjective::Bool

  ### extra values
  search_hash::String

  ### callbacks
  after_save::Function

  ### constructor
  Tweet(;
    id = Nullable{SearchLight.DbId}(),
    tweet_id = "",
    text = "",
    user_name = "",
    screen_name = "",
    avatar_url = "",
    favorite_count = 0,
    retweet_count = 0,
    polarity = -100,
    subjective = false,

    search_hash = "",

    after_save = (m::Tweet) -> Channels.broadcast(["tweets-" * m.search_hash], "tweet", SearchLight.to_dict(m))

  ) = new("tweets", "id", id, tweet_id, text, user_name, screen_name, avatar_url,
          favorite_count, retweet_count, polarity, subjective, search_hash, after_save)
end

const EMPTY_DATA = ([], [0, 0, 0], [0, 0], "[]", "[]")

function tweets_stats(tweets::Vector{Tweet}) :: Tuple{Vector{Int},Vector{Int}}
  favorites_count = Int[]
  retweets_count = Int[]

  for tweet in tweets
    push!(favorites_count, tweet.favorite_count)
    push!(retweets_count, tweet.retweet_count)
  end

  favorites_count, retweets_count
end

function tweets_aggregates(filters) :: Tuple{Vector{Int},Vector{Int}}
  result = SearchLight.query_raw("
    SELECT
      CAST(SUM(polarity = -1) AS SIGNED) AS negative,
      CAST(SUM(polarity = 0) AS SIGNED) AS neutral,
      CAST(SUM(polarity = 1) AS SIGNED) AS positive,
      CAST(SUM(subjective = TRUE) AS SIGNED) AS subjective,
      CAST(SUM(subjective = FALSE) AS SIGNED) AS objective
    FROM tweets
    WHERE $(filters[1]) $(filters[2] |> string )") |> first

  [result[:negative], result[:neutral], result[:positive]], [result[:subjective], result[:objective]]
end

end
