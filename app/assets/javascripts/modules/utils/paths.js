
// Session module
define([
  //no deps
],

/*
 * Keep application wide pathing here to seamlessly change
 * on API changes and other pathing issues.
 */
function() {
  
  var Paths = {
    SignIn: "/users/sign_in",
    SignOut: "/users/sign_out"
  };

  return Paths;

});
