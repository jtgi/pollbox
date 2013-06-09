define([], function() {

  var Flash = function(data) {
    console.log("Flashing...", data);
    if(data) {
      if(data.hasOwnProperty('errors')) {
        $("#flash").html("<div class='error'><ul id='errorList'></ul></div>");
        _.each(data.errors, function(val, key) {
          $("#errorList").append("<li>"+ key + " " + "<ul>"+ _.reduce(val, function(memo, msg) { memo + "<li>"+msg+"</li>" }) +"</ul></li>");
        });
      } else if(data.hasOwnProperty('error')) {
        $("#flash").html("<div class='error'><ul id='errorList'><li>"+data.error+"</li></ul></div>");
      }
    }
  }

  return Flash;

})

