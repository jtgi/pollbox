// Session module
define([
  // Application.
  "app",
  "modules/user",
  "text!templates/login.html"
],

// Map dependencies from above array.
function(app, User, loginHTML) {

  // Create a new module.
  var Session = app.module();

  Session.Model = Backbone.Model.extend({

    initialize: function() {
      this.bindEvents();
    },

    bindEvents: function() {
      _.bindAll(this,
                "handleLoginSuccess",
                "handleLoginError",
                "handleLogoutSuccess",
                "handleLogoutError",
                "handleGetUserSuccess",
                "handleGetUserError"
      );
    },

    toJSON: function() {
      return { user: _.clone( this.attributes ) }
    },

    login: function(email, password) {
      console.log("Logging in user...", email, password);

      var loginData = {
        email: email,
        password: password
      };

      app.Ajax.login(loginData, this.handleLoginSuccess, this.handleLoginError);
    },

    handleLoginSuccess: function(response, stat, xhr) {
      console.log("Successfully logged in", response);
      app.trigger(app.Events.Session.LOGIN);
      app.router.navigate("dashboard", {trigger: true});
    },

    handleLoginError: function(response, stat, xhr) {
      console.log("Error during login");
      console.log(response.responseText);
      var responseObj = JSON.parse(response.responseText);
      app.Flash.display(responseObj);
    },

    logout: function() {
      console.log("Attempting to logout...");
      $.ajax({
        url: app.Paths.get("signOut"),
        success: this.handleLogoutSuccess,
        error: this.handleLogoutError,
        type: "DELETE"
      });
    },

    handleLogoutSuccess: function(model, response, opts) {
      console.log("Successfully logged out", response);
      app.trigger("session:logout");
      app.router.navigate("", {trigger: true})
    },

    handleLogoutError: function(model, response, opts) {
      console.log("Error during logout", model, response, opts);
      app.Flash.display({ error: response.responseText });
    },


    clearCookie: function() {
      $.cookie("sessionKey", "");
      $.cookie("userId", "");
    },
    /*
     * TODO: Backbone is supposed to call user/:id
     * when a model is instantiated with an id param.
     * For whatever reason, this is not the case.
     *
     * @return User.Model populated with logged in user's
     * data.
     */
    getUser: function() {
        if(this.user) {
            return this.user;
        } else {
          $.ajax({
              url: app.Paths.get("user"),
              success: this.handleGetUserSuccess,
              error: this.handleGetUserError,
              dataType: "json",
              type: "GET"
          });
        }
    },

    handleGetUserSuccess: function(data) {
        console.log("Successfully retrieved user", data);
        this.user = new User.Model(data);
    },

    handleGetUserError: function() {
        console.log("Error retrieving user");
    },


    /*
     * Helper function to run validations app-wide.
     * Compares.
     */
    loggedIn: function() {
      //Return false for empty string
      return Boolean($.cookie("signed_in"));
    },

    authorizeUser: function() {
        if(!this.loggedIn()) {
           app.router.navigate("login", {trigger: true});
        }
    },

    isEmail: function(email) {
      //Basic client-side email check
      var re = /\S+@\S+\.\S+/;
      return re.test(email);
    }

 });

  Session.Views.Login = Backbone.View.extend({
    template:_.template(loginHTML),
    
    events: {
      'click #login': 'tryLogin'
    },

    validate: function(fields) {
      return this.model.isEmail(fields.email) && fields.password;
    },

    fields: function() {
      return {
        email: $("#login-form").find('input[name=email]').val(),
        password: $("#login-form").find('input[name=password]').val()
      }
    },

    tryLogin: function(evt) {
      evt.stopImmediatePropagation();
      var fields = this.fields();
      if(this.validate(fields)) {
        this.model.login(fields.email, fields.password);
      } else {
        //TODO: Show Error Handling on Form
      }
    },

    render: function() {
      console.log("Rendering Login Form");
      this.$el.html(this.template());
      return this;
    }

  });
  
  // Return the module for AMD compliance.
  return Session;

});
