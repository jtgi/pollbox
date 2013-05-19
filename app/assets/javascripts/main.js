require([
  "app",
  "modules/session",
  "router"
],

function(app, Session, Router) {

  app.session = new Session.Model();
  app.router = new Router();

  /* Initialize App Events */

  /*
   * Expects data in form of:
   * { "errors": { "email": ["msg1", "msg2"] ... } }
   */
  app.flash = function(data) {
    if(data.hasOwnProperty('errors')) {
      $("#flash").html("<div class='error'><ul id='errorList'></ul></div>");
      _.each(data.errors, function(val, key) {
        $("#errorList").append("<li>"+ key + " " + "<ul>"+ _.reduce(val, function(memo, msg) { memo + "<li>"+msg+"</li>" }) +"</ul></li>");
      });
    }
  }

  app.on("user:new:success", function(data) {
    app.session.login(data.attributes.email, data.attributes.password);
  }, this);

  // Trigger the initial route and enable HTML5 History API support, set the
  // root folder to '/' by default.  Change in app.js.
  Backbone.history.start({ pushState: true, root: app.root });

  // All navigation that is relative should be passed through the navigate
  // method, to be processed by the router. If the link has a `data-bypass`
  // attribute, bypass the delegation completely.
  $(document).on("click", "a[href]:not([data-bypass])", function(evt) {
    // Get the absolute anchor href.
    var href = { prop: $(this).prop("href"), attr: $(this).attr("href") };
    // Get the absolute root.
    var root = location.protocol + "//" + location.host + app.root;

    // Ensure the root is part of the anchor href, meaning it's relative.
    if (href.prop.slice(0, root.length) === root) {
      // Stop the default event to ensure the link will not cause a page
      // refresh.
      evt.preventDefault();

      // `Backbone.history.navigate` is sufficient for all Routers and will
      // trigger the correct events. The Router's internal `navigate` method
      // calls this anyways.  The fragment is sliced from the root.
      Backbone.history.navigate(href.attr, true);
    }
  });

});
