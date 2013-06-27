define([
       "backbone",
       "modules/utils/paths",
       "modules/utils/events",
       "modules/utils/flash",
       "modules/utils/ajax",
       "jquery-cookie"
], function(Backbone, Paths, Events, Flash, Ajax) {

  var app = {
    // The root path to run the application.
    root: "/"
  };

  return _.extend(app, {
    'Paths': Paths,
    'Events': Events,
    'Flash': Flash,
    'Ajax': Ajax,

    // Create a custom object with a nested Views object.
    module: function(additionalProps) {
      return _.extend({ Views: {} }, additionalProps);
    }
  }, Backbone.Events);

});
