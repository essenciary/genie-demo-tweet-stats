require('chart.js');

const MAX_TWEETS = 20;

window.polarityChart = new Chart('polarity-chart', {
  type: 'doughnut',
  data: {
    labels: ['Negative', 'Neutral', 'Positive'],
    datasets: [{
      data: polarity,
      backgroundColor: ['#FA709A', '#ECE4D9', '#2AF598']
    }]
  },
  options: {
    animation: { animateScale: true },
    legend: {
      position: 'bottom',
      labels: { boxWidth: 12 }
    }
  }
});

window.subjectivityChart = new Chart('subjectivity-chart', {
  type: 'pie',
  data: {
    labels: ['Subjective', 'Objective'],
    datasets: [{
      data: subjectivity,
      backgroundColor: ['#EF7B47', '#7ACCC8']
    }]
  },
  options: {
    animation: { animateScale: true },
    legend: {
      position: 'bottom',
      labels: { boxWidth: 12 }
    }
  }
});

window.tweetsChart = new Chart('tweets-chart', {
  type: 'bar',
  data: {
    labels: Array(MAX_TWEETS).fill(''),
    datasets: [
      {
        label: 'Retweets count',
        backgroundColor: '#7B6D8D',
        data: retweets
      },
      {
        label: 'Favorites count',
        backgroundColor: '#593F62',
        data: favorites
      }
  ]
  },
  options: {
    animation: { animateScale: true },
    legend: {
      position: 'bottom',
      labels: { boxWidth: 12 }
    },
    scales: {
      xAxes: [{ stacked: true }],
      yAxes: [{ stacked: true }]
    }
  }
});

$(document).ready(
  function() {
    // add callback to receive pushed messages
    Channels.messageHandlers.push(function(event){
      if (event.data.startsWith('{') && event.data.endsWith('}')) {
        parse_payload(JSON.parse(event.data));
      }
    });

    // subscribed to tweets notifications
    Channels.sendMessageTo('tweets', 'subscribe', { 'search_term': document.getElementById('txtSearch').value } );

    function parse_payload(message_data) {
      if ( message_data.channel == 'tweets-' + document.getElementById('txtSearch').value && message_data.message == 'tweet' ) {
        var tweet = message_data.payload;
        var tweet_dom = build_tweet_dom(tweet);

        if ( ! $('#tweet_' + tweet.id).length ) {
          $('#tweets_list').prepend(tweet_dom);

          update_polarity_graph(tweet.polarity);
          update_subjectivity_graph(tweet.subjective);
          update_tweets_graph(tweet);

          var tweets = document.querySelectorAll('#tweets_list > li');
          if ( tweets.length > MAX_TWEETS ) {
            var last_tweet = tweets[tweets.length - 1];
            document.querySelector('#tweets_list').removeChild(last_tweet);
          }
        }
      }
    }

    function build_tweet_dom(tweet) {
      return `
        <li class="list-group-item" id="tweet_${tweet.id}">
          <div class="row">
            <div class="col-sm-1 col-xs-2">
              <img src="${tweet.avatar_url}" alt="user" class="img-circle" />
            </div>
            <div>
              ${tweet.user_name} @${tweet.screen_name} ${tweet.text} ${sentiment_labels(tweet.polarity)} ${subjectivity_labels(tweet.subjective)} &nbsp;
              <span class="glyphicon glyphicon-retweet label label-default retweet-count" aria-hidden="true">
                ${tweet.retweet_count}
              </span> &nbsp;
              <span class="glyphicon glyphicon-heart label label-default favorite-count" aria-hidden="true">
                ${tweet.favorite_count}
              </span>
            </div>
          </div>
        </li>`;
    }

    function sentiment_labels(polarity) {
      return `<span class="label label-default ${polarity_class_name(polarity)}">${sentiment(polarity)}</span>`;
    }

    function polarity_class_name(polarity) {
      if ( polarity == -1 ) {
        return 'sentiment-negative';
      } else if ( polarity == 1 ) {
        return 'sentiment-positive';
      } else {
        return 'sentiment-neutral';
      }
    }

    function sentiment(polarity) {
      if ( polarity == -1 ) {
        return 'Negative';
      } else if ( polarity == 1 ) {
        return 'Positive';
      } else {
        return 'Neutral';
      }
    }

    function subjectivity_labels(sbj) {
      return `<span class="label label-default ${subjectivity_class_name(sbj)}">${subjectivity(sbj)}</span>`;
    }

    function subjectivity_class_name(subjective) {
      return subjective ? 'subjectivity-subjective' : 'subjectivity-objective';
    }

    function subjectivity(subjective) {
      return subjective ? 'Subjective' : 'Objective';
    }

    function update_polarity_graph(polarity) {
      var data_array = window.polarityChart.data.datasets[0].data;

      if ( polarity == -1 ) {
        data_array[0] += 1;
      } else if ( polarity == 1 ) {
        data_array[2] += 1;
      } else {
        data_array[1] += 1;
      }

      window.polarityChart.data.datasets[0].data = data_array;
      window.polarityChart.update();
    }

    function update_subjectivity_graph(subjectivity) {
      var data_array = window.subjectivityChart.data.datasets[0].data;

      subjectivity === true ? data_array[0] += 1 : data_array[1] += 1;

      window.subjectivityChart.data.datasets[0].data = data_array;
      window.subjectivityChart.update();
    }

    function update_tweets_graph(tweet) {
      var retweets_data_array = window.tweetsChart.data.datasets[0].data;
      var favorites_data_array = window.tweetsChart.data.datasets[1].data;

      retweets_data_array.unshift(tweet.retweet_count);
      retweets_data_array.length > MAX_TWEETS && retweets_data_array.pop();


      favorites_data_array.unshift(tweet.favorite_count);
      favorites_data_array.length > MAX_TWEETS && favorites_data_array.pop();

      window.tweetsChart.update();
    }
  }
);
