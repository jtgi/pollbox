define([
  // Application.
  "app",
  "modules/poll",
  "modules/base",
  "modules/user",
  "modules/room",
  "modules/session",
  "modules/dashboard",
  "text!templates/home.html"
],

function(app, Poll, Base, User, Room, Session, Dashboard, HomeHTML) {

  var Router = Backbone.Router.extend({

    routes: {
      "": "home",
      "poll": "poll",
      "login": "login",
      "logout": "logout",
      "signup": "signup",
      "room": "room",
      "dashboard": "dashboard"
    },


    //Render core UI elements
    //TODO: Refactor these templates, they're
    //static HTML.
    initialize: function() {
      var nav = new Base.Views.Nav();
      var footer = new Base.Views.Footer();
      $("#nav").append(nav.render().el);
      $("footer").append(footer.render().el);
     },

    home: function() {
      var template = _.template(HomeHTML);
      $("#main").html(template(app));
    },

    /**
     * TODO: If user is logged in, render dashboard
     */
    dashboard: function() {
        this.authorizeUser();
        //Fetch current user from session
        var user = app.session.getUser();
        var dashboard = new Dashboard.Model();
        var dashboardView = new Dashboard.Views.Base({model:dashboard});
        $("#main").html(dashboardView.render().el);
    },

    room: function(roomId) {
      var room = new Room.Model();
      var roomView = new Room.View({ model:room });
      room.connect();
    },

    signup: function() {
      var user = new User.Model();
      var userSignup = new User.Views.Signup({model:user});
      $("#main").html(userSignup.render().el);
    },

    login: function() {
      if(this.isLoggedIn()) {
        app.router.navigate("dashboard", {trigger:true});
      } else {
        var login = new Session.Views.Login({model: app.session});
        $("#main").html(login.render().el);
      }
    },

    logout: function() {
      confirm("Are you sure you want to log out?");
      console.log("Logging out user...");
      app.session.logout();
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
