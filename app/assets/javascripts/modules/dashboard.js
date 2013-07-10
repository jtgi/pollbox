// Dashboard module
define([
  // Application.
  "app",
  "text!templates/dashboard.html"
],

// Map dependencies from above array.
function(app, dashboardHTML) {

  // Create a new module.
  var Dashboard = app.module();

  // Default Model.
  Dashboard.Model = Backbone.Model.extend({
    /*
     * TODO: Dashboard needs to spawn off more
     * sub models and needs access to a number of 
     * different user data.
     * - User Profile Data
     * - User's Rooms
     * - News/Whatevers
     *
     * Maybe the dashboard is just a communications
     * layer, or a mediator between its necessary models.
     */
  });

  // Default Collection.
  Dashboard.Collection = Backbone.Collection.extend({
    model: Dashboard.Model
  });

  // Default View.
  Dashboard.Views.Base = Backbone.View.extend({
    template: _.template(dashboardHTML),
    tagName: "div",
    className: "dashboard-container",
    initialize: function() {},
    enterRoom: function() {},
    render: function() {
      console.log("Rendering Dashboard");
      var data = this.model.toJSON();
      _.extend(data, app);
      this.$el.html(this.template(data));
      return this;
    }
  });

  // Return the module for AMD compliance.
  return Dashboard;

});
