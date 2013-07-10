require([
  "app",
  "modules/session",
  "router"
],

function(app, Session, Router) {

  app.session = new Session.Model();
  app.router = new Router();

  Backbone.history.start({ pushState: true, root: app.root });

  //Disable links from rendering new pages, log history for back button
  $(document).on("click", "a[href]:not([data-bypass])", function(evt) {
    var href = { prop: $(this).prop("href"), attr: $(this).attr("href") };
    var root = location.protocol + "//" + location.host + app.root;

    if (href.prop.slice(0, root.length) === root) {
      evt.preventDefault();
      Backbone.history.navigate(href.attr, true);
    }
  });

});
