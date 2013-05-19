// Signup module
define([
  // Application.
  "app"
],

// Map dependencies from above array.
function(app) {

  // Create a new module.
  var Signup = app.module();

  // Default Model.
  Signup.Model = Backbone.Model.extend({
  
  });

  // Default Collection.
  Signup.Collection = Backbone.Collection.extend({
    model: Signup.Model
  });

  // Default View.
  Signup.View = Backbone.View.extend({
    template: _.template(signupHTML);
  });

  // Return the module for AMD compliance.
  return Signup;

});
