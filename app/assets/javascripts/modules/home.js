

define([
  "app",
  "text!templates/home.html"
],

function(app, HomeHTML) {

  // Create a new module.
  var Home = app.module();

  Home.Views.Landing = Backbone.View.extend({
    events: {
      "click #create-room": "createRoom"
    },

    template: _.template(HomeHTML),

    createRoom: function() {
      var postObj = {};
      _.each(this.fields(), function(val, key) {
        postObj[key] = val;
      });

      if(this.isValid(postObj)) {
        app.Ajax.createRoom({ room: postObj }, this.handleCreateRoomSuccess, this.handleCreateRoomError);
      } else {
        app.Flash.display({ error: "Invalid data, try again" });
      }
    },

    isValid: function(postObj) {
      //TODO: Improve room validation
      return (postObj.name) ? true : false;
    },

    handleCreateRoomSuccess: function(response) {
      console.log("Successfully created room", response);
      //var url = app.Paths.rooms + "/" + response.room.id;
      var url = app.Paths.rooms + "/" + 1;
      app.router.navigate(url, { trigger: true });
    },

    handleCreateRoomError: function(response) {
      console.log("Error creating room", response);
      app.Flash.display(response);
    },

    fields: function() {
      return { 
        name: $("#room-name").val() 
      };
    },

    render: function () {
      this.$el.html(this.template(app));
      return this;
    }

  });

  // Return the module for AMD compliance.
  return Home;

});
