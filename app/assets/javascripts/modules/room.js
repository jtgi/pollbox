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
    url: app.Paths.get("rooms"),
    initialize: function(roomId) {
      this.initializeEvents();
      _.bindAll(this, "handleRoomConnectionError","handleRoomConnectionSuccess");
      this.set("id", roomId);
      this.connectToRoom();
    },

    initializeEvents: function() {
      app.on(app.Events.Room.initializePoll, this.initializePoll);
    },

    initializePoll: function(data) {
      var poll = Poll.createNewPoll(data);
      this.setAsActivePoll(poll);
    },

    setAsActivePoll: function(poll) {
      if(this.isPollCurrentlyDisplayed()) {
        archivePoll();
      }
      this.set('activePoll', poll);
    },

    isPollCurrentlyDisplayed: function() {
      //TODO: Add check for for presence in UI
      return this.activePoll;
    },

    archivePoll: function() {
      //TODO: Implement me.
      //Remove poll from being displayed
      //Archive somewhere
    },

    connectToRoom: function() {
      this.trigger(app.Events.Room.connecting);
      this.handleRoomConnectionSuccess(); //TODO: remove this once auth resolved
      this.set('title', "Room Debug Title");
      //this.fetch({
      //  success: handleRoomConnectionSuccess,
      //  error: handleRoomConnectionError
      //});
    },

    handleRoomConnectionSuccess: function(data) {
      this.trigger(app.Events.Room.connected, data);
    },

    handleRoomConnectionError: function(response, status, xhr) {
      console.log("Error fetching rooms");
      var responseObj = $.parseJSON(response.responseText);
      app.Flash(responseObj);
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
      this.model.on(app.Events.Room.connecting, this.connecting(data));
      this.model.on(app.Events.Room.connected, this.initializeRoom(data));
    },

    events:{
      'change:activePoll': 'renderPoll'
      
    },

    render:function() {
      console.log("Rendering Room");
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    initializeRoom: function(data) {
      console.log("Initialize Room");
      $("#main").html(this.render().el);
      $(".connecting").html("Connected!").addClass("success").delay(500).fadeOut(500);
    },

    connecting: function(data) {
      console.log("Connecting...");
      $("#nav").append("<div data-alert class='connecting alert-box'>Connecting to room...<a href='#' class='close'>&times;</a></div>");
    },

    renderPoll: function(room, poll, opts) {
      $(".poll-hook").html(poll.render().el);
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
