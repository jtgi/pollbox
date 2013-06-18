// Room module
define([
  // Application.
  "app",
  "modules/room_connection",
  "text!templates/room.html",
  "modules/poll"
],

// Map dependencies from above array.
function(app, RoomConnection, RoomHTML, Poll) {

  // Create a new module.
  var Room = app.module();

  // Default Model.
  Room.Model = Backbone.Model.extend({

    url: app.Paths.get("rooms"),

    initialize: function(roomId) {
      this.set("id", roomId);
      this.bindEvents();
      this.conn = new RoomConnection(this);
    },

    connect: function() {
      this.conn.connect();
    },

    bindEvents: function() {
      this.on(app.Events.Room.CONNECTED, this.updateRoomData, this);
    },

    updateRoomData: function(roomData) {
      console.log("Updating Room Data...", roomData);
      this.set(roomData);
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
      this.model.on(app.Events.Room.CONNECTING, this.connecting, this);
      this.model.on("change", this.initializeRoom, this);
    },

    events:{
      'change:activePoll': 'renderPoll'
    },

    connecting: function() {
      console.log("connecting fired in view");
      app.Flash.display({message:"Connecting to room"});
    },

    render:function() {
      console.log("Rendering Room");
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    initializeRoom: function(data) {
      $("#main").html(this.render().el);
      app.Flash.display({success:"Connected to room"});
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
