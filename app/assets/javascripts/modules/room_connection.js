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

  var RoomConnection = function(roomRef) {

    this.room = roomRef;

    this.connect = function() {
        console.log("Connecting to room...");
        this.room.trigger(app.Events.Room.CONNECTING);
        var self = this;
        setTimeout(function() { self.connected(self.roomData()) }, 2000);
    };

    this.connected = function(roomData) {
      console.log("Connection established");
      this.room.trigger(app.Events.Room.CONNECTED, roomData, this);
    };

    this.disconnect = function() {
        this.room.trigger(app.Events.Room.DISCONNECTING);

        //do stuff

        this.room.trigger(app.Events.Room.DISCONNECTED);
    };


    this.createPoll = function() {
      console.log("createpoll in conn");
      this.room.trigger(app.Events.Room.INITIALIZE_POLL, this.pollData("ready", 4, false));
    };

    this.updatePoll = function(status, userVoted) {
      this.room.trigger(app.Events.Poll.DATA_RECEIVED, this.pollData(status, 4, userVoted));
    };

    this.openPoll = function() {
      this.updatePoll("open", false);
    };

    this.refreshPoll = function() {
      this.updatePoll("open", false);
    };

    this.userVote = function() {
      this.updatePoll("open", true);
    };

    this.closePoll = function() {
      this.updatePoll("closed", true);
    };

    this.submitPoll = function() {
      console.log("Poll Data should be submitted here");
    };

    this.roomData =  function() {
      return {
        id: 12,
        title:"CS221 Lecture #12 - Parallelism",
        description:"No desc.",
        owned:false
      };
    };

    //Generate some test data
    this.pollData = function(status, numPollOptions, userVoted) {

      var date = new Date();
      var pollOptionsArr = [];
      for(var i=0; i < numPollOptions; i++) {
        pollOptionsArr.push({
          pollOption: {
            id: date.getMilliseconds() % 20,
            label: i,
            answer: "The is extended answer for option " + i,
            voteCount: date.getSeconds() % 50
          }
        });
      }

      return {
        id:12,
        title:"Who's the auntie derivative of jemima?",
        status: status,
        pollOptions: pollOptionsArr,
        userVoted: userVoted,
        totalVotes: 122
      };
    };


  };

  return RoomConnection;

});
