// Room module
define([
  // Application.
  "app",
  "text!templates/room.html",
  "modules/poll"
],

// Map dependencies from above array.
function(app, RoomHTML, Poll) {

  // Create a new module.
  var Room = app.module();

  // Default Model.
  Room.Model = Backbone.Model.extend({

    /**
     * Establish socket.io connection
     * TODO: Add error handling to the connection
     * for socket events. Consider better placement
     * for socket binding.
     */
    initRoom: function(data) {
      console.log("Initializing Room..");
      this.trigger("room:connected", data);
    },

    connect: function(data) {
      this.trigger("room:connecting", data);
    }

  });

  
  // Default Collection.
  Room.Collection = Backbone.Collection.extend({
    model: Room.Model
  });

  // Default View.
  Room.View = Backbone.View.extend({
    template: _.template(RoomHTML),
    tagName: "div",
    className: "room-container",
    initialize: function(data) {
      this.model.on("room:createPoll", this.createPoll(data));
      this.model.on("room:connecting", this.connecting(data));
      this.model.on("room:connected", this.initRoom(data));
    },

    events:{
      'click .init-poll': 'initPoll'
    },

    render:function() {
      console.log("Rendering Room");
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    /**
     * Sends a message over the socket to 
     * initiate polling.
     * TODO: Agree on the JSON needed here.
     */
    initPoll: function(event) {
      this.createPoll();
    },

    initRoom: function(data) {
      console.log("Initialize Room");
      $("#main").html(this.render().el);
      $(".connecting").html("Connected!").addClass("success").delay(500).fadeOut(500);
    },

    connecting: function(data) {
      //TODO: Generalize this alert dialog
      console.log("Connecting...");
      $("#nav").append("<div data-alert class='connecting alert-box'>Connecting to room...<a href='#' class='close'>&times;</a></div>");
    },

    createPoll: function(data) {
      //TODO: Should pass in Poll attr. via socket.io evt.
      //to initialize Poll Model.
      console.log("Creating Poll");

      this.poll = new Poll.Model({
        pollId:2, 
        roomId:777, 
        title:"Variables in Java are 100% static?"
      });

      this.pollView = new Poll.View({model:this.poll});
      $(".poll-hook").html(this.pollView.render().el);

    },
    closeRoom: function() {},
    updatePoll: function() {},
    closePoll: function() {},
    addUser: function() {},
    removeUser: function() {},
    allUsers: function() {}
   });

  // Return the module for AMD compliance.
  return Room;

});
