define([
  // Application.
  "app",
  "modules/home",
  "modules/base",
  "modules/poll",
  "modules/user",
  "modules/room",
  "modules/session",
  "text!templates/home.html"
],

function(app, Home, Base, Poll, User, Room, Session, HomeHTML) {

  var Router = Backbone.Router.extend({

    routes: {
      "": "home",
      "poll": "poll",
      "rooms/:id": "room"
    },

    initialize: function() {
      var nav = new Base.Views.Nav();
      var footer = new Base.Views.Footer();
      $("#nav").append(nav.render().el);
      $("footer").append(footer.render().el);
    },

    home: function() {
      var landingView = new Home.Views.Landing();
      $("#main").html(landingView.render().el);
    },

    room: function(roomId) {
      console.log("Routing to room, id: ", roomId);
      var room = new Room.Model(roomId);
      var roomView = new Room.View({ model:room });
      room.connect();
    },

    poll: function() {
      var poll = new Poll.Model();
      var pollView = new Poll.View({model:poll});
      $("#main").html(pollView.render().el);
    },

    authorizeUser: function() {
      if(!app.session.loggedIn()) {
        //TODO: Add get request to urlBar
        app.router.navigate("login", {trigger:true});
      }
    },

    isLoggedIn: function() {
      return app.session.loggedIn();
    }

  });

  return Router;

});
