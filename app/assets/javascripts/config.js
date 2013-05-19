// Set the require.js configuration for your application.
require.config({

  // Initialize the application with the main application file.
  deps: ["main"],
  //Base URL is assets as this is where rails' asset pipeline
  //compiles and place files
  baseUrl: "/assets",
  paths: {
    //These paths are appended to baseURL. When a file is
    //referenced in a 'require' block at the head of a javascript
    //file it looks up this path.
    //EX:
    //require([ "backbone" ], function(Backbone) { ... });
    //the path to find "backbone" is computed using baseURL + path
    //in this case: assets/backbone/backbone(.js) (auto adds .js)
    "underscore": 'underscore/underscore',
    "text": 'text/text',
    "backbone": "backbone/backbone",
    "jquery": "jquery/jquery",
    "jquery-cookie": "jquery-cookie-amd/jquery.cookie"
  },

  map: {
    // Put additional maps here.
  },

  shim: {
    "backbone": {
      "deps": [
        "jquery",
        "underscore"
      ],
      "exports": "Backbone"
    },
    "underscore": {
      "exports": "_"
    },
    "jquery": {
      "exports": "$"
    }
  }

});
