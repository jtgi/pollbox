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
      _.bindAll(this,
                "handleLoginSuccess", 
                "handleLoginError",
                "handleLogoutSuccess",
                "handleLogoutError");
      this.load();
    },


    toJSON: function() {
      return { user: _.clone( this.attributes ) }
    },

    load: function() {},

    login: function(email, password) {
      console.log("Attempting to login...", this);

      $.ajax({
        url: app.Paths.get("signIn", false),
        success: this.handleLoginSuccess,
        error: this.handleLoginError,
        data: { user: { email: email, password: password } },
        dataType: "json",
        type: "POST"
      });

    },

    handleLoginSuccess: function(response, status, xhr) {
      console.log("Successfully logged in", response);
      app.trigger("session:login");
      app.router.navigate("dashboard", {trigger: true});
    },

    handleLoginError: function(response, status, xhr) {
      console.log("Error during login", response, status, xhr);
      var responseObj = $.parseJSON(response.responseText);
      app.flash(responseObj);
    },

    logout: function() {
      console.log("Attempting to logout...");
      $.ajax({
        url: app.Paths.get("signOut", false),
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
      app.flash({ error: response.responseText });
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
      if(this.loggedIn()) {
        //Pass in the userId so backbone pulls and not posts.
        console.log(app.session.get('userId'));
        var user = new User.Model({userId: app.session.get("userId")});
        console.log("New user?", user.isNew());
        user.fetch({ 
          success: function(data)  {
           // TODO: make user available app-wide somehow here
          }
        });
      } else {
        app.router.navigate("login", {trigger: true});
      }
    },

    /*
     * Helper function to run validations app-wide.
     * Compares.
     */
    loggedIn: function() {
      //Return false for empty string
      return Boolean($.cookie("signed_in"));
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
