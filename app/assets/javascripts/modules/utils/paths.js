
define([
  //no deps
],

/*
 * Keep application wide pathing here to seamlessly change
 * on API changes and more.
 */
function() {

  var Paths = {
    apiRoot: "",
    signIn: "/users/sign_in",
    signOut: "/users/sign_out",
    rooms: "/rooms",
    polls: "/polls",
    usersRooms: '/users/:id/rooms'
  };

  Paths.get = function(key, params) {
    try {
      var url = this.apiRoot + this[key];
      if(params) {
        url = insertParamsIntoUrl(url, params);
      }
      return url;
    } catch(e) {
      console.log("Path doesn't exist: " + e.message);
    }
  };

  Paths.insertParamsIntoUrl = function(url, params) {
    _.each(params, function(val, key) {
      var target = ":" + key;
      if(url.match(target)) {
        url.replace(target, val);
      }
      return url;
    });
  };

  return Paths;

});
