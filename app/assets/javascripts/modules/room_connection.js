define([
    "app",
    "private_pub",
],

/*
Responsibility of the RoomConnection is to manage the connection,
and trigger the room when network events occur.
 */
function(app, PrivatePub) {

  var RoomConnection = function(roomRef) {

    this.room = roomRef;

    this.connect = function() {
      console.log("Connecting to room...");
      this.room.trigger(app.Events.Room.CONNECTING);
      app.Ajax.getRoomData({ id: this.room.id }, this.connected, this.handleConnectError);
    };

    this.connected = function(data) {
      var roomData = data.room;
      console.log("Received roomData: ", roomData);

      //TODO: We need a callback here upon connection complete
      //As well some real room data. When do we receive data for
      //the room? On connect complete, or immediately following?
      //how do I request data through the channel?
      PrivatePub.sign(JSON.parse(roomData.vote_subscription));
      var self = this;
      setTimeout(function() {
        console.log("subscribing...", self.getChannelName(roomData.name));
        PrivatePub.subscribe(self.getChannelName(roomData.name), function(data, channel) {
          console.log("Callback reached", data.message);
        });
      }, 5000);
      this.room.trigger(app.Events.Room.CONNECTED, roomData, this);
    };

    this.getChannelName = function(roomName) {
      return "/" + roomName + "/master";
    };

    this.parseData = function(data) {
      console.log("Message received, parsing data");
      if(data.room) {
        console.log("Room data detected", data.room);
        this.roomDataReceived(data.room);
      } else if(data.poll) {
        console.log("Poll data detected", data.poll);
        this.pollDataReceived(data.poll);
      } else {
        console.log("Invalid data", data);
      }
    };

    this.pollDataReceived = function(pollData) {
      this.room.trigger(app.Events.Poll.DATA_RECEIVED, pollData);
    };

    this.roomDataReceived = function(roomData) {
      this.room.trigger(app.Events.Room.DATA_RECEIVED, pollData);
    };

    this.disconnect = function() {
        this.room.trigger(app.Events.Room.DISCONNECTING);

        //do stuff

        this.room.trigger(app.Events.Room.DISCONNECTED);
    };

    this.submitVote = function() {

    };

    //test functions
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
        id: 44,
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
        id:66,
        title:"Who's the auntie derivative of jemima?",
        status: status,
        pollOptions: pollOptionsArr,
        userVoted: userVoted,
        totalVotes: 122
      };
    };

    _.bindAll(this, "connected");

  };

  return RoomConnection;

});
