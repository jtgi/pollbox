// Poll module
define([
  // Application.
  "app",
  "text!templates/poll.html"
],

// Map dependencies from above array.
function(app, PollHTML) {

  console.log("created poll");
  // Create a new module.
  var Poll = app.module();

  // Default Model.
  Poll.Model = Backbone.Model.extend({
   defaults: {
      pollId: 1,
      roomId: 2,
      title:"Demo Title",
      active: "open",
      options: {
        'A': 0,
        'B': 0,
        'C': 0,
        'D': 0
      }
    },

    initialize: function() {},
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

    /**
    * Toggles the appearance of all poll options
    * when one is selected.
    *
    * @method togglePollOptions
    * @param {String} chosen id of clicked poll opt
    */

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

    /**
     * Updates poll UI, delegates submittal of
     * vote to model.
     *
     * @method vote
     * @param {Object} evt poll option clicked
     */

    vote: function(evt) {
      console.log(evt.currentTarget.id + " clicked");
      this.togglePollOptions(evt.currentTarget.id);
      var optLabel = evt.currentTarget.id;
      this.model.vote(optLabel);
    }

 });

  // Return the module for AMD compliance.
  return Poll;

});
