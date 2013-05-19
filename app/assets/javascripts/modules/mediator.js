// Mediator module
define([
  // Application.
  "app"
],

// Map dependencies from above array.
function(app) {

  //Copy BackBone.Events which is already
  //a nice pub/sub
  var Mediator = _.clone(Backbone.Events);

  /*
   * MEDIATOR PATTERN 
   * All module-to-module events routed through the
   * mediator to de-couple modules and allow further
   * control of validation, custom events etc.
   * May be able to further extend this to add custom
   * methods for app specific events.
   */

  Mediator.attachEvent = function(events, callback, context) {
    this.on(events, callback, context);
    console.log("This is: ", this);
  }

  Mediator.dispatchEvent = function(events) {
    this.trigger(events);
  }


  /*
   * SOCKET/PUSH EVENTS
   * Delegate methods out to relevant socket/push library
   * (socket.io, cramp, pusher, etc.). This prevents
   * us from having to edit module level code across-app
   * if we change libraries.
   * TODO: This may need to be pulled out into another 
   * module. We'll how the socket/push binding is done.
   */

  Mediator.attachPushEvent = function(events, callback, context) {
    this.on(events, callback, context);
  }

  Mediator.dispatchPushEvent = function(events) {
    this.trigger(events);
  }

  // Return the module for AMD compliance.
  return Mediator;

});
