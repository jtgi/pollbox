

define([
  //no deps
],

/*
 * Keep application wide event strings here to seamlessly change
 * on API changes and more.
 */
function() {

  var Events = {

    Session: {
      LOGIN: "session:login",
      LOGOUT: "session:logout"
    },

    Room: {
      CONNECTING: "room:connecting",
      CONNECTED: "room:connected",
      DISCONNECTING: "room:disconnecting",
      DISCONNECTED: "room:disconnected",
      INITIALIZE_POLL: "room:initializePoll"
    },

    Poll: {},
    User: {},
    Dashboard: {}
  };

  return Events;

});