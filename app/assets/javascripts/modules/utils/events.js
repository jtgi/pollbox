

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
      login: "session:login",
      logout: "session:logout"
    },

    Room: {
      connecting: "room:connecting",
      connected: "room:connected",
      initializePoll: "room:initializePoll"
    },

    Poll: {},
    User: {},
    Dashboard: {}
  };

  return Events;

});
