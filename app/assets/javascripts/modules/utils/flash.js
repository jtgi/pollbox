define([], function() {

  var Flash = {

    display: function(data) {
      if(_.isString(data)) {
        this.display({ message: data});
      }

      if(data) {
        console.log(data);
        if(data.hasOwnProperty('errors')) {
          this.writeTag("error", this.buildErrorList(data.errors));
          $("#flash").html("<div data-alert class='error alert-box'><ul id='errorList'></ul></div>");
        } else if(data.hasOwnProperty('error')) {
          this.writeTag("error", data.error);
        } else if(data.hasOwnProperty('success')) {
          this.writeTag("success", data.success);
        } else if(data.hasOwnProperty('message')) {
          this.writeTag("message", data.message);
        }
      }
    },

    writeTag: function(type, content) {
      $("#flash").show().html("<div data-alert class='" + type + " alert-box'>" + content + "</div>").delay(2000).fadeOut();
    },

    buildErrorList: function(errors) {
      var content = "";
      _.each(errors, function(val, key) {
        content += "<li>"+ key + " " + "<ul>"+ _.reduce(val, function(memo, msg) { memo + "<li>"+msg+"</li>" }) +"</ul></li>";
      });
      return content;
    }
  };

  return Flash;

});

