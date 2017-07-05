export Tweet, Tweets

using Channels

type Tweet <: AbstractModel
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
  subjective::Union{Bool,Int}

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

module Tweets

using App, SearchLight

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
      SUM((polarity = -1)::int) AS negative,
      SUM((polarity = 0)::int) AS neutral,
      SUM((polarity = 1)::int) AS positive,
      SUM((subjective = TRUE)::int) AS subjective,
      SUM((subjective = FALSE)::int) AS objective
    FROM tweets
    WHERE $(filters[1]) $(filters[2] |> string )") |> first

  map(result) do (r)
    r == Union{} ? 0 : r
  end

  [result[1], result[2], result[3]], [result[4], result[5]]
end

end
