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
    //Used to give a default invalid session.
    url: "/session",
    defaults: {
      email: "",
      password: "",
      userId: "",
      sessionKey: ""
    },

    initialize: function() {
      //Use bindAll to maintain context of 'this'
      //specifically in ajax success/error response
      //Reference: http://tinyurl.com/3vxywxa
      _.bindAll(this, "handleSuccess", "handleError");
      this.load();
    },

    load: function() {
      this.set({
        //userId: $.cookie('userId'),
        //sessionKey: $.cookie('sessionKey')
      });
    },

  /*
   * TODO: 
   * this.save() should return http 400 and user details.
   * Server-side: If credentials valid, should fill out 
   * set a unique sessionKey, remove password and 
   * then send back the result.
   */
    login: function(email, password) {
      this.set({
        email: email,
        password: password,
      }, { silent: true });

      this.save({}, {
        success: this.handleSuccess,
        error: this.handleError
      });
    },

    handleSuccess: function(model, response, opts) {
      console.log("Successfully logged in", response);
      this.load();
      app.trigger("session:login");
      app.router.navigate("dashboard", {trigger: true})
    },

    handleError: function(model, response, opts) {
      console.log("Error during login", model, response, opts);
      app.flash({ error: response.responseText });
    },

    logout: function() {
      this.clearCookie();
      this.clear();
      app.trigger("session:logout");
      app.router.navigate("", {trigger:true});
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
      return Boolean(this.get("sessionKey"));
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
      'click #login': 'attemptLogin'
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

    attemptLogin: function(evt) {
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
