# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.App =
  completeProjectLine : (data) ->
    html = ""
    watchs = ""
    if data[3] != ""
      watchs = "<abbr>(#{data[3]} Watchers)</abbr>"
    html += "<div class='info'><a href=\"#{data[1]}\">#{data[0]}</a>#{watchs}<br />#{data[4]}</div>"
    html

  completeProjects : (el) ->
    hash =
      minChars: 1
      delay: 50
      width: 350
      scroll : false
      formatItem : (data, i, total) ->
        return App.completeProjectLine(data)
    $(el).autocomplete("/projects/search",hash).result (e, data, formatted) ->
      location.href = "#{data[1]}"
      return false

$(document).ready ->
  App.completeProjects(".searchbox input.query")
