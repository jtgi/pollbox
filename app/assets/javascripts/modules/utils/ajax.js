
define([
  "modules/utils/paths"
],

/*
 * Manage non backbone related ajax calls through this util class
 * on API changes and more.
 */
function(Paths) {

  var Ajax = {

    //Class calls
    login: function(data, success, error) {
      var url = Paths.get("signIn");
      this.makePostRequest(data, success, error, url);
    },

    getUser: function(success, error) {
      var url = Paths.get("user");
      this.makeGetRequest(success, error, url, false);
    },

    createRoom: function(data, success, error) {
      var url = Paths.get("rooms");
      this.makePostRequest(data, success, error, url);
    },

    getRoomData: function(params, success, error) {
      var url = Paths.get("roomByRoomId", { id: params.id });
      this.makeGetRequest(success, error, url);
    },

    submitVote: function(data, success, error) {
      var url = Paths.get("submitVote", { poll_option_id: data.pollOptionId });
      this.makePostRequest(data, success, error, url);
    },

    // Util Calls
    makeGetRequest: function(success, error, url, async) {
      this.makeRequest(null, success, error, url, "GET", async);
    },

    makePostRequest: function(data, success, error, url) {
      this.makeRequest(data, success, error, url, "POST");
    },

    makeRequest: function(data, success, error, url, type, async) {
      data = (data) ? JSON.stringify(data) : null,
      success = success || this.handleSuccess;
      error = error || this.handleError;
      async = (typeof async === 'undefined') ? true : async;

      $.ajax({
        url: url,
        beforeSend: function(request)
        {
          request.setRequestHeader("Content-Type: application/json");
          request.setRequestHeader("Accept: application/json");
        },
        success: success,
        error: error,
        async: async,
        data: data,
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
