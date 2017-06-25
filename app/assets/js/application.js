require('../css/application.css');

const WEBSOCKETS_SERVER = true;

if ( WEBSOCKETS_SERVER ) {
  require('./channels.js');
  Channels.load_channels();

  Channels.messageHandlers.push(function(event){
    // console.log(event.data);
  });
}

require('./tweets.js');
