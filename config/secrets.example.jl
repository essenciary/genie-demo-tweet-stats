const SECRET_TOKEN = "c7c1784996e9592516a880b9cee2b635aff92d1dcd694c5862b2dc4fb3217fd4"

# Follow the instructions at https://github.com/randyzwitch/Twitter.jl to setup
# access for the Twitter library
const TWITTER_TOKENS = ["... your consumer key ...",
                        "... your consumer token ...",
                        "... your oauth token ...",
                        "... your oauth secret..."]

# In order to use the Aylien Sentiment Analysis API you need to setup a free account with them: http://docs.aylien.com/docs/api-key
const AYLIEN_TOKENS = Dict{Symbol,String}(:app_id => "... your app id ...", :api_key => "... your api key ...")
