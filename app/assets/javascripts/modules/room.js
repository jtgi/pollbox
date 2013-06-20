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
    polls: [],
    activePoll: {},

    initialize: function(roomId) {
      this.set("id", roomId);
      this.bindEvents();
      this.conn = new RoomConnection(this);
    },

    connect: function() {
      this.conn.simulate();
    },

    bindEvents: function() {
      this.on(app.Events.Room.CONNECTED, this.updateRoomData, this);
      this.on(app.Events.Room.INITIALIZE_POLL, this.initializePoll, this)
    },

    updateRoomData: function(roomData) {
      console.log("Updating Room Data...", roomData);
      this.set(roomData);
    },

    initializePoll: function(data) {
      console.log("Initializing poll with data:", data);
      _.extend(data, {'room':this});
      var poll = Poll.createNewPoll(data);
      this.polls.push(poll);
      this.setAsActivePoll(poll);
    },

    setAsActivePoll: function(poll) {
      if(this.isPollCurrentlyDisplayed()) {
        this.archivePoll();
      }
      this.set('activePoll', poll);
    },

    isPollCurrentlyDisplayed: function(poll) {
      return this.get('activePoll') != null;
    },

    archivePoll: function() {
      this.get("activePoll").archive();
      this.set('activePoll', null);
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
      this.model.on("change:id", this.initializeRoom, this);
      this.model.on("change:activePoll", this.renderPoll, this);
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
      app.Flash.display({success:"Connected to room"});
      $("#main").html(this.render().el);
    },

    renderPoll: function(room, poll, opts) {
      app.Flash.display({success:"A poll has begun!"});
      $(".poll-hook").html(poll.render().el);
    },

    closeRoom: function() {},
    closePoll: function() {},
    addUser: function() {},
    removeUser: function() {},
    allUsers: function() {}
   });

  // Return the module for AMD compliance.
  return Room;

});
