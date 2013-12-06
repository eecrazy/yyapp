# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
tc =0
$ ->
  app_id = $("#app-id").text()
  urlnow = window.location.pathname
  $('.tag-form').css("display","none")
  $("#addtag").html("<img src=\"/assets/add4.png\">")
  $("#addtag").click ->
    if tc ==0
      $('.tag-form').css("display","block")
      $("#addtag").html("<img src=\"/assets/add5.png\">")
      tc = 1
    else if tc == 1
      $('.tag-form').css("display","none")
      $("#addtag").html("<img src=\"/assets/add4.png\">")
      tc =0
  $(".sb-tag").click ->
    tag_name = $(".c-tag").val().trim()
    $.ajax 
      url : "/tag_it"
      type : "POST"
      data: {"tag_name" :tag_name, "app_id" : app_id}
    $('.ptag').append("<a href=\"/tags/#{tag_name}\">#{tag_name}</a>")
  
  is_like = $("#is-like").text()
  if  is_like == "0"
    $("#likeable").html("<img src=\"/assets/like.png\"><span>Like It</span>")       
  else if is_like == "1"
    $("#likeable").html("<img src=\"/assets/unlike.png\"><span>Cancel</span>")
  else
     $("#likeable").hide()  
  
  $("#likeable").click ->
    $.ajax
      url : "/like"
      type : "POST"
      data: {"cho" : $("#is-like").text(), "app_id" : app_id}
    if urlnow == "/guess"
      window.location.href= "/guess"
    if $("#is-like").text() == "0"
      $("#is-like").text(1)
      $("#likeable").html("<img src=\"/assets/unlike.png\"><span>Cancel</span>") 
    else if $("#is-like").text() == "1"
      $("#is-like").text(0)
      $("#likeable").html("<img src=\"/assets/like.png\"><span>Like It</span>")

  is_hate = $("#is-hate").text()
  if  is_hate == "0"
    $("#hateable").html("<img src=\"/assets/hate.png\"><span>Hate It</span>")       
  else if is_hate == "1"
    $("#hateable").html("<img src=\"/assets/unhate.png\"><span>Cancel</span>")
  else
     $("#hateable").hide()  
  
  $("#hateable").click ->
    $.ajax
      url : "/hate"
      type : "POST"
      data: {"cho" : $("#is-hate").text(), "app_id" : app_id}
    if $("#is-hate").text() == "0"
      $("#is-hate").text(1)
      $("#hateable").html("<img src=\"/assets/unhate.png\"><span>Cancel</span>") 
    else if $("#is-hate").text() == "1"
      $("#is-hate").text(0)
      $("#hateable").html("<img src=\"/assets/hate.png\"><span>Hate It</span>")
    if urlnow == "/guess"
      window.location.href= "/guess"
