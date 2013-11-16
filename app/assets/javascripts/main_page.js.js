// Generated by CoffeeScript 1.6.3
(function() {
  window.App = {
    completeProjectLine: function(data) {
      var html, watchs;
      html = "";
      watchs = "";
      if (data[3] !== "") {
        watchs = "<abbr>(" + data[3] + " Watchers)</abbr>";
      }
      html += "<div class='info'><a href=\"" + data[1] + "\">" + data[0] + "</a>" + watchs + "<br />" + data[4] + "</div>";
      return html;
    },
    completeProjects: function(el) {
      var hash;
      hash = {
        minChars: 1,
        delay: 50,
        width: 350,
        scroll: false,
        formatItem: function(data, i, total) {
          return App.completeProjectLine(data);
        }
      };
      return $(el).autocomplete("/projects/search", hash).result(function(e, data, formatted) {
        location.href = "" + data[1];
        return false;
      });
    }
  };

  $(document).ready(function() {
    return App.completeProjects(".searchbox input.query");
  });

}).call(this);
