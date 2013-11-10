# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".add-url-image").bind "click", () ->
    #alert $(this).text()
    imageurl =  $(".image-url").val()
    $.ajax
      url : "/images"
      type : "POST"
      data: {"imageurl" : imageurl}
      

  
  # $(".add-local-image").bind "click", () ->
  #   $("#upload-images").click()

  # opts =
  #   url : "/images"
  #   type : "POST"
  #   success : (result) ->
  #     alert "1"
  # $("#upload-images").fileUpload opts
      
