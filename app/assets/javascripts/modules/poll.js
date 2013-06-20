// Poll module
define([
  // Application.
  "app",
  "text!templates/poll.html"
],

// Map dependencies from above array.
function(app, PollHTML) {

  // Create a new module.
  var Poll = app.module();

  Poll.createNewPoll = function(data) {
      var poll = new Poll.Model(data);
      return new Poll.View({model:poll});
  };



  Poll.Model = Backbone.Model.extend({

    initialize: function() {
      this.get("room").on(app.Events.Poll.DATA_RECEIVED, this.updatePoll, this);
    },

    States: {
      OPEN: 'open',
      CLOSED: 'closed',
      DISABLED: 'disabled'
    },

    updatePoll: function(pollData) {
      this.set(pollData);
    },

    getStatus: function() {
      return this.state;
    },

    vote: function(pollOption) {
      console.log("Building vote JSON for: "+pollOption);
      var voteJSON = {
        userId: app.session.get("userId"),
        pollId: this.get("pollId"),
        roomId: app.session.get("roomId"),
        choice: pollOption
      };

      console.log("Vote POST should be done here");
      console.log(voteJSON);
      app.dispatchPushEvent("vote:submit", voteJSON);
    }

  });
  
  // Default Collection.
  Poll.Collection = Backbone.Collection.extend({
    model: Poll.Model
  });

  // Default View.
  Poll.View = Backbone.View.extend({
    template: _.template(PollHTML),
    tagName: "div",
    className: "poll-container",

    events: {
      'click .poll-option': 'vote'
    },

    initialize: function() {
      console.log("Poll initialized");
      this.model.on('change', this.render, this);
    },

    render: function () {
      console.log("Rendering poll");
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    togglePollOptions: function(chosen) {
      $(".poll-controller .poll-option").each(function(){
        if($(this).attr("id")===chosen) {
          $(this).addClass("success");
          $(this).removeClass("secondary");
        } else {
          $(this).addClass("secondary");
          $(this).removeClass("success");
        }
      });
    },

    vote: function(evt) {
      console.log(evt.currentTarget.id + " clicked");
      this.togglePollOptions(evt.currentTarget.id);
      var optLabel = evt.currentTarget.id;
      this.model.vote(optLabel);
    },

    archive: function() {
        //Implement me
        //Add to side panel list collection
    }

 });

  // Return the module for AMD compliance.
  return Poll;

});
