define([
       "backbone",
       "modules/utils/paths",
       "modules/utils/events",
       "modules/utils/flash",
       "jquery-cookie"
], function(Backbone, Paths, Events, Flash) {

  var app = {
    // The root path to run the application.
    root: "/"
  };

  return _.extend(app, {
    'Paths': Paths,
    'Events': Events,
    'Flash': Flash,

    // Create a custom object with a nested Views object.
    module: function(additionalProps) {
      return _.extend({ Views: {} }, additionalProps);
    }
  }, Backbone.Events);

});
