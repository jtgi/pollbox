
// Session module
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
    polls: "/polls"
  };

  Paths.get = function(str, includeRoot) {
      includeRoot = typeof includeRoot == 'undefined' ? true : false;
      try {
          var url;
          if(includeRoot) {
              url = this.apiRoot;
          }
          return this[str];
      } catch(e) {
          console.log("Path doesn't exist: " + e.message);
      }
  };

  return Paths;

});
