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

    /*
     * Rebuild rails has_many relationships by instantiating
     * a collection of rooms on the user model.
     * this gives us: user.rooms for use throughout app.
     * Perhaps weigh the consequences of this coupling later.
     * Note: This will cause user.sync to attempt to sync
     * user's associated rooms.
     */
    initialize: function() {
      this.rooms = new Room.Collection();
      this.rooms.url = 'users/' + this.id + '/rooms';
      _.bindAll(this, "handleCreateUserSuccess", "handleCreateUserError");
    },

    toJSON: function() {
      return { user: _.clone( this.attributes ) }
    },

    createUser: function(attrs) {
        //TODO: This will report an error until it
        //receives JSON back from the server.
        //see: http://tinyurl.com/ctmdblb
        this.save(attrs, {
          success: this.handleCreateUserSuccess,
          error: this.handleCreateUserError
        });
    },

    handleCreateUserSuccess: function(model, response, opts) {
      console.log("Successfully created user");
      app.trigger("user:new:success");
    },

    handleCreateUserError: function(model, response, opts) {
      console.log(response.responseText);
      var responseObj = $.parseJSON(response.responseText);
      app.flash(responseObj);
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

  /*
   * =====================================
   * 
   *            SIGN UP VIEW
   *
   * =====================================
   *
   */
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

    /*
     * Gather form input
     */
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
