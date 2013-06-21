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
      self.connect();

      setTimeout(function(){
          self.connected(
            {
                id:3,
                title:"CS213 - Lecture #4 - Finite State Machines",
                description:"My room bitch niz",
                owned:false
            });
        }, 4000);

      var pollDataInterval;
      setTimeout(function() { 
        self.initializePoll();
        pollDataInterval = setInterval(function() { 
          self.updatePoll(); }, 2000);
      }, 10000);

      setTimeout(function() {
        clearInterval(pollDataInterval);
        self.updatePoll("closed");
      }, 20000);
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
      var date = new Date();
      var pollData = {
        id:12,
        title:"Who's the auntie derivative of jemima?",
        status: "ready",
        pollOptions: [
        {
            pollOption: 
            {
              label: "A",
              answer: "The is option A",
              voteCount: date.getSeconds()
            }
        },
        {
          pollOption: 
          {
            label: "B",
            answer: "This is option B",
            voteCount: date.getMilliseconds() % 100
          }
        }
        ],
        userVoted: false
      };

      room.trigger(app.Events.Room.INITIALIZE_POLL, pollData);

    };

    this.updatePoll = function(closed) {
      var date = new Date();
      var pollData = {
        id:12,
        title:"Who's the auntie derivative of jemima?",
        status: (closed==null) ? "open" : closed,
        pollOptions: [
        {
            pollOption: 
            {
              label: "A",
              answer: "The is option A",
              voteCount: date.getSeconds() % 50
            }
        },
        {
          pollOption: 
          {
            label: "B",
            answer: "This is option B",
            voteCount: date.getMilliseconds() % 100
          }
        }
        ],
        userVoted: false
      };


      room.trigger(app.Events.Poll.DATA_RECEIVED, pollData, this);

    }

  };

  return RoomConnection;

});
