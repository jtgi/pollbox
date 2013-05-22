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
      console.log(template);
      $("#main").html(template(app));
    },

    /**
     * TODO: If user is logged in, render dashboard
     */
    dashboard: function() {
      //TODO: This should be pulled out into some
      //rails-like before_filter for all specified
      //routes.
      //Ideally: somewhere in router we specify which
      //routes are protected.
      //function() mustBeLoggedIn('dashboard', 'room', ...)
      if(app.session.loggedIn()) {
        var dashboard = new Dashboard.Model();
        var dashboardView = new Dashboard.Views.Base({model:dashboard});
        $("#main").html(dashboardView.render().el);

        //Fetch current user from session
        var user = app.session.getUser();
        console.log("returned user");
      } else {
        //TODO: Should remember previous url upon failed attempt
        //at accessing a page.
        app.router.navigate("login", {trigger:true});
      }
    },

    /**
     * For Testing purposes.
     * TODO: Should be passed roomId, make a request 
     * for room info and render accordingly.
     */
    room: function(roomId) {
      var room = new Room.Model();
      var roomView = new Room.View({model:room});
      room.initRoom({title:"CS213 - Computational Resources"});
    },

    signup: function() {
      var user = new User.Model();
      var userSignup = new User.Views.Signup({model:user});
      $("#main").html(userSignup.render().el);
    },

    login: function() {
      if(app.session.loggedIn()) {
        app.router.navigate("dashboard", {trigger:true});
      } else {
        var login = new Session.Views.Login({model: app.session});
        $("#main").html(login.render().el);
      }
    },

    /**
     * Destroy session and redirect to home page.
     * TODO: Should only redirect after successfully
     * destroying session, maybe pass a callback?
     */
    logout: function() {
      confirm("Are you sure you want to log out?");
      console.log("Logging out user...");
      app.session.logout();
    },

    /**
     * Creates a poll
     * For testing purposes only.
     */
    poll: function() {
      var poll = new Poll.Model();
      var pollView = new Poll.View({model:poll});
      $("#main").html(pollView.render().el);
   }

  });

  return Router;

});
