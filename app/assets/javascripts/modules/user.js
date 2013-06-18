// User module
define([
  // Application.
  "app",
  "modules/room",
  "text!templates/user.html",
  "text!templates/signup.html"
],

// Map dependencies from above array.
function(app, Room, userHTML, userSignup) {

  // Create a new module.
  var User = app.module();

  // Default Model.
  User.Model = Backbone.Model.extend({
    url: '/users',
    idAttribute: "userId",
    defaults: {
      "first_name": "",
      "last_name": "",
      "email": "",
      "password": "",
      "password_confirmation": ""
    },

    initialize: function() {
      this.rooms = new Room.Collection();
      this.rooms.url = app.Paths.get("usersRooms", {id: this.id});
      _.bindAll(this, "handleCreateUserSuccess", "handleCreateUserError");
    },

    toJSON: function() {
      return { user: _.clone( this.attributes ) }
    },

    createUser: function(attrs) {
        this.save(attrs, {
          success: this.handleCreateUserSuccess,
          error: this.handleCreateUserError
        });
    },

    handleCreateUserSuccess: function(model, response, opts) {
      console.log("Successfully created user");
      app.trigger(app.Events.Session.LOGIN);
      app.router.navigate("dashboard", {trigger:true});
    },

    handleCreateUserError: function(model, response, opts) {
      console.log(response.responseText);
      var responseObj = $.parseJSON(response.responseText) 
      app.Flash.display(responseObj);
    },

  });

  // Default Collection.
  User.Collection = Backbone.Collection.extend({
    model: User.Model
  });

  // Default View.
  User.View = Backbone.View.extend({
    template: _.template(userHTML)
  });


 User.Views.Signup = Backbone.View.extend({
    id: "sign-up-wrap",
    template: _.template(userSignup),

    initialize: function () {},

    events:{
      'click #sign-up': 'tryCreateUser'
    },

    render: function() {
      console.log("Rendering Signup Form");
      this.$el.html(this.template());
      return this;
    },

    tryCreateUser: function(evt) {
      //TODO: Add prevention for double submitting form
      //Prevent anchor from following href
      evt.stopImmediatePropagation();
      var attrs = this.attributes();
      if(this.validate(attrs)) {
        this.model.createUser(attrs);
      }
    },

    validate: function(attrs, options) {
      //TODO: Validate form data.and display errors
      //to user
      return true;
    },

    attributes: function() {
      return {
          //studentId: $("#sign-up-wrap").find('input[name=student_id]').val(),
          //name: $("#sign-up-wrap").find('input[name=name]').val(),
          email: $("#sign-up-wrap").find('input[name=email]').val(),
          password: $("#sign-up-wrap").find('input[name=password]').val(),
          password_confirmation: $("#sign-up-wrap").find('input[name=password_confirmation]').val(),
      };
    }

  });


  // Return the module for AMD compliance.
  return User;

});
