# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  id = $('input[name=followed_id]').val()
  $('.relationship-block').on 'click', '.unfollow', ->
    editRelationship id, 'DELETE', "relationships/#{id}"
  $('.relationship-block').on 'click', '.follow', ->
    editRelationship id, 'POST', "relationships?followed_id=#{id}"
# $('.unfollow').click ->
#   id = $('input[name=followed_id]').val()
#   unfollowUser id

editRelationship = (id, method, url) ->
  $.ajax
    url: url
    type: method
    dataType: 'json'
    success: (data) ->
      console.log data
    complete: (data) ->
      if data.status == 200
        $('.relationship-block').empty()
        $('.relationship-block').append data.responseText
