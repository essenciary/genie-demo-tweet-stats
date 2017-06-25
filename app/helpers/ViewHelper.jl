module ViewHelper

using Genie, Helpers, App

export sentiment_labels, subjectivity_labels

function sentiment_labels(sentiment_value::Int) :: String
  class_name, sentiment =   if sentiment_value == -1
                              "sentiment-negative", "Negative"
                            elseif sentiment_value == 1
                              "sentiment-positive", "Positive"
                            else
                              "sentiment-neutral", "Neutral"
                            end

  """<span class="label label-default $class_name">$sentiment</span>"""
end

function subjectivity_labels(subjective::Bool) :: String
  class_name, subjectivity =  subjective ? ("subjectivity-subjective", "Subjective") : ("subjectivity-objective", "Objective")

  """<span class="label label-default $class_name">$subjectivity</span>"""
end

end
