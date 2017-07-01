module TweetsController

using App, SearchLight, JSON, Toolbox
@dependencies

function index()
  search_term = haskey(@params, :q) ? lowercase(@params(:q)) : ""
  startswith(search_term, "#") && (search_term = search_term[2:end])

  recent_searches = SearchLight.find(Search, SQLQuery(order = "id DESC", limit = 10))

  tweets, polarity, subjectivity, favorites_count, retweets_count = if isempty(search_term)
    Tweets.EMPTY_DATA
  else
    filters = ["polarity != -100", SQLWhereExpression("text LIKE ?", "%$(search_term)%")]
    tweets = SearchLight.find(Tweet, SQLQuery(where = filters, limit = 20, order = "id DESC"))

    search = Search(search = search_term)
    SearchLight.create_or_update_by!!(search, :search)

    isempty(tweets) ? (Tweets.EMPTY_DATA) : (tweets, Tweets.tweets_aggregates(filters)..., Tweets.tweets_stats(tweets)...)
  end

  respond_with_html(:tweets, :index,  search_term = search_term, tweets = tweets, recent_searches = recent_searches,
                                      polarity = JSON.json(polarity), subjectivity = JSON.json(subjectivity),
                                      favorites_count = favorites_count, retweets_count = retweets_count)
end

end
