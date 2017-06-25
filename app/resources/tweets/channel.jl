module TweetsChannel

using Channels, App
@dependencies

function subscribe()
  haskey(@params(:payload), "search_term") &&
    ! isempty(@params(:payload)["search_term"] |> strip) &&
      Channels.subscribe(wsclient(@params), "tweets-" * @params(:payload)["search_term"])
  "OK"
end

end
