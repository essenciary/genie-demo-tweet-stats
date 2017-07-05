module SentimentAnalysis

using Requests, URIParser, Macros, Logger, App, SearchLight

type SentimentData
  polarity::Int
  polarity_name::String
  subjective::Union{Bool,Int}
end

const AYLIEN_API_URL = "https://api.aylien.com/api/v1/sentiment"
const AYLIEN_APP_KEY_HEADER = "X-AYLIEN-TextAPI-Application-Key"
const AYLIEN_APP_ID_HEADER = "X-AYLIEN-TextAPI-Application-ID"

function analyze(text::String) :: SentimentData
  sentiment = Requests.get( AYLIEN_API_URL * "?mode=tweet&text=$(URIParser.escape(text))",
                            headers = Dict{String,String}(AYLIEN_APP_KEY_HEADER => App.AYLIEN_TOKENS[:api_key],
                                                          AYLIEN_APP_ID_HEADER => App.AYLIEN_TOKENS[:app_id])) |> Requests.json |> to_sentimentdata
end

function to_sentimentdata(data::Dict{String,Any}) :: SentimentData
  try
    polarity =  if data["polarity"] == "positive"
                  1
                elseif data["polarity"] == "negative"
                  -1
                else
                  0
                end

    subjective = data["subjectivity"] == "subjective" ? SearchLight.adapter_type(true) : SearchLight.adapter_type(false)

    SentimentData(polarity, data["polarity"], subjective)
  catch ex
    Logger.log(string(ex), :err)
    Logger.log(@location_in_file, :err)

    SentimentData(0, "N/A", true)
  end
end

end
