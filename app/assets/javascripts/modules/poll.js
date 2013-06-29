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

    States: {
      READY: 'ready',
      OPEN: 'open',
      CLOSED: 'closed',
    },

    initialize: function() {
      this.get("room").on(app.Events.Poll.DATA_RECEIVED, this.updatePoll, this);
    },

    updatePoll: function(pollData) {
      this.set(pollData);
    },

    getStatus: function() {
      return this.state;
    },

    vote: function(pollOptionId) {
      var voteJSON = {
        pollId: this.get("id"),
        roomId: this.get("room").get("id"),
        pollOptionId: pollOptionId,
      };

      console.log("Submitting vote: ", voteJSON);
      app.Ajax.submitVote(voteJSON, this.voteSuccessHandler, this.voteErrorHandler);
    },

    voteSuccessHandler: function() {
      console.log("Vote success!");
    },

    voteErrorHandler: function() {
      console.log("Vote error!");
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

    render: function (model, change) {
      console.log("Rendering poll... ");
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    togglePollOptions: function(chosen) {
      $(".poll-controller .poll-option").each(function(){
        if($(this).attr("id") === chosen) {
          $(this).addClass("success");
          $(this).removeClass("secondary");
        } else {
          $(this).addClass("secondary");
          $(this).removeClass("success");
        }
      });
    },

    vote: function(evt) {
      var pollOptionIdAttr = evt.currentTarget.id;
      console.log("Console id", pollOptionIdAttr);
      this.togglePollOptions(pollOptionIdAttr);
      var pollOptionId = this.parseVoteInt(pollOptionIdAttr);
      this.model.vote(pollOptionId);
    },

    //Expects format: <div id="id-12">
    parseVoteInt: function(idAttribute) {
      var id = "";

      var idPos = idAttribute.indexOf("id-");
      if(idPos == -1) {
        throw new Error("Error: Could not parse id. Expected format id='id-<integer>' and found: " + idAttribute);
      } else {
        return idAttribute.substring(idPos + 3);
      }

    },

    archive: function() {
        console.log("Archiving poll");
    }

 });

  // Return the module for AMD compliance.
  return Poll;

});
