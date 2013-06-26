define([
       "app",
       "modules/room_connection"
],

/*
 * Handles coordinating the communication between all
 * the room components. All events are passed through
 * the room mediator, the mediator decides what components
 * need to know about it.
 */
function(app, RoomConnection) {

  var RoomMediator = function(room) {

    this.room = room;
    this.on(app.Events.Room.CONNECTING, this.connecting());
    this.on(app.Events.Room.CONNECTED, this.connected());

    this.initializePoll = function() {},
    this.openPoll = function() {},
    this.closePoll = function() {},

    this.connecting = function() {
    },
    this.connected = function() {},
    this.disconnecting = function() {},
    this.disconnected = function() {}

  };

  return _.extend(RoomMediator, Backbone.Events);

});
