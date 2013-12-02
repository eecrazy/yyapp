# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  is_like = $("#is-like").text()
  app_id = $("#app-id").text()
  if  is_like == "0"
    $("#likeable").html("<img src=\"/assets/like.png\"><span>Like</span>")       
  else if is_like == "1"
    $("#likeable").html("<img src=\"/assets/unlike.png\"><span>Dislike</span>")
  else
     $("#likeable").hide()  

  $("#likeable").click ->
    $.ajax
      url : "/like"
      type : "POST"
      data: {"cho" : $("#is-like").text(), "app_id" : app_id}
      success : (result, status, xhr) ->
        $("#like-val span").text(result)
        if $("#is-like").text() == "0"
           $("#is-like").text(1)
           $("#likeable").html("<img src=\"/assets/unlike.png\"><span>Dislike</span>") 
        else if $("#is-like").text() == "1"
           $("#is-like").text(0)
           $("#likeable").html("<img src=\"/assets/like.png\"><span>Like</span>")
    false
