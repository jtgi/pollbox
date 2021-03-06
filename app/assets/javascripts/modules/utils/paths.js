
define([
  //no deps
],

/*
 * Keep application wide pathing here to seamlessly change
 * on API changes and more.
 */
function() {

  var Paths = {
    apiRoot: "/api/v1",

    signIn: "/users/sign_in",
    signOut: "/users/sign_out",

    rooms: "/rooms",
    roomByRoomId: "/rooms/:id",
    roomPollsByRoomId: '/rooms/:id/polls',

    polls: "/polls",
    pollByPollId: "/polls/:id",
    submitVote: "/poll_option/:poll_option_id/vote",

    user: "/user",
    users: "/users",
    userByUserId: "/users/:id",
    userRoomsByUserId: '/users/:id/rooms'
  };

  Paths.get = function(key, params) {
    try {
      var url = this.apiRoot + this[key];
      if(params) {
        url = this.insertParamsIntoUrl(url, params);
      }
      return url;
    } catch(e) {
      console.log("Path doesn't exist: " + e.message);
    }
  };

  Paths.insertParamsIntoUrl = function(url, params) {
    for(var key in params) {
      if(params.hasOwnProperty(key)) {
        var target = ":" + key;
        if(url.match(target)) {
          url = url.replace(target, params[key]);
        }
      }
    }
    return url;
  };

  return Paths;

});
