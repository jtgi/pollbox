
// Base module
// ===========
// Defines the static elements of the app like
// Navigation, Footers, Branding, etc.
//

define([
  // Baselication.
  "app",
  "text!templates/nav.html",
  "text!templates/footer.html"
],

// Map dependencies from above array.
function(app, NavHTML, FooterHTML) {

  // Create a new module.
  var Base = app.module();

  Base.Views.Nav = Backbone.View.extend({
    template: _.template(NavHTML),
    initialize: function() {
      app.on(app.Events.Session.LOGIN, this.render, this);
      app.on(app.Events.Session.LOGOUT, this.render, this);
    },

    render: function () {
      this.$el.html(this.template(app));
      return this;
    }
  });

  Base.Views.Footer = Backbone.View.extend({
    template: _.template(FooterHTML),
    render: function () {
      this.$el.html(this.template);
      return this;
    }
  });

  // Return the module for AMD compliance.
  return Base;

});
