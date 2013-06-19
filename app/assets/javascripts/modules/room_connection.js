define([
    "app",
    "modules/room_mediator",
    "modules/utils/events"
],

/*
Responsibility of the RoomConnection is to manage the connection,
and trigger the mediator when network events occur.
 */
function(app, RoomMediator) {

  var RoomConnection = function(room) {

    this.room = room;
    //initialize room channels here
    //subscribe("some_channel", room);

    this.connect = function() {
        console.log("Connecting to room...");
        this.room.trigger(app.Events.Room.CONNECTING);

        //TODO: Establish faye/socket connection here.

        var self = this;
        setTimeout(function(){
          self.connected(
            {
                id:3,
                title:"CS213 - Lecture #4 - Finite State Machines",
                description:"My room bitch niz",
                owned:false
            });
        }, 2000);
    };

    this.connected = function(roomData) {
      console.log("Connection established");
      this.room.trigger(app.Events.Room.CONNECTED, roomData);
    },

    this.disconnect = function() {
        room.trigger(app.Events.Room.DISCONNECTING);

        //do stuff

        room.trigger(app.Events.Room.DISCONNECTED);
    };

  };


  return RoomConnection;

});
