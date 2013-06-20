define([
    "app",
    "modules/room_mediator",
    "modules/utils/events"
],

/*
Responsibility of the RoomConnection is to manage the connection,
and trigger the room when network events occur.
 */
function(app, RoomMediator) {

  var RoomConnection = function(room) {

    this.room = room;
    //initialize room channels here
    //subscribe("some_channel", room);
    this.simulate = function() {
      var self = this;
      setTimeout(function() { self.connect() }, 4000);

      setTimeout(function(){
          self.connected(
            {
                id:3,
                title:"CS213 - Lecture #4 - Finite State Machines",
                description:"My room bitch niz",
                owned:false
            });
        }, 10000);

      setTimeout(function() { 
        self.initializePoll();
        setInterval(function() { 
          self.updatePoll(); }, 2000);
      }, 15000);

    },

    this.connect = function() {
        console.log("Connecting to room...");
        this.room.trigger(app.Events.Room.CONNECTING);
    };

    this.connected = function(roomData) {
      console.log("Connection established");
      this.room.trigger(app.Events.Room.CONNECTED, roomData, this);
     },

    this.disconnect = function() {
        room.trigger(app.Events.Room.DISCONNECTING);

        //do stuff

        room.trigger(app.Events.Room.DISCONNECTED);
    };

    this.initializePoll = function() {
        var poll = {
            pollId: 1,
            roomId: 2,
            title:"What is the anti-derivative of your uncle bob?",
            status: "open",
            options: {
                'A': 0,
                'B': 0,
                'C': 0,
                'D': 0
            },
            userVoted: false
        };

        room.trigger(app.Events.Room.INITIALIZE_POLL, poll);

    };

    this.updatePoll = function() {
      var date = new Date();
      var pollData = {
        pollId: 1,
        roomId: 2,
        title:"What is the anti-derivative of your uncle bob?",
        status: "open",
        options: {
          'A': date.getMilliseconds() % 50,
          'B': date.getMilliseconds() % 80,
          'C': date.getMilliseconds() % 150,
          'D': date.getMilliseconds() % 409,
        },
        userVoted: false
      };

      room.trigger(app.Events.Poll.DATA_RECEIVED, pollData, this);

    }

  };

  return RoomConnection;

});
