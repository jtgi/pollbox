
define([
  //no deps
  "modules/utils/paths"
],

/*
 * Manage non backbone related ajax calls through this util class
 * on API changes and more.
 */
function(Paths) {

  var Ajax = {

    submitVote: function(data, success, error) {
      var url = Paths.get("submitVote", { poll_option_id: data.pollOptionId });
      this.makePostRequest(data, success, error, url);
    },

    makePostRequest: function(data, success, error, url) {
      this.makeRequest(data, success, error, url, "POST");
    },

    makeRequest: function(data, success, error, url, type) {
      success = success || this.handleSuccess;
      error = error || this.handleError;

      $.ajax({
        url: url,
        beforeSend: function(request)
        {
          request.setRequestHeader("Content-Type: application/json");
          request.setRequestHeader("Accept: application/json");
        },
        success: success,
        error: error,
        data: JSON.stringify(data),
        dataType: "json",
        type: type
      });
    },

    handleError: function() {
      console.log("Error: Using generic error handler");
    },

    handleSuccess: function() {
      console.log("Success: Using generic success handler");
    }

  };

  return Ajax;

});
