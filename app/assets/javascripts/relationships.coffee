# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
INC_FOLLOWERS = 1
DEC_FOLLOWERS = -1

$(document).ready ->
  id = $('input[name=followed_id]').val()
  $('.relationship-block').on 'click', '.unfollow', ->
    editRelationship id,
      'DELETE',
      "relationships/#{id}",
      DEC_FOLLOWERS

  $('.relationship-block').on 'click', '.follow', ->
    editRelationship id,
      'POST',
      "relationships?followed_id=#{id}",
      INC_FOLLOWERS


editRelationship = (id, method, url, followers) ->
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
        updateFollowers followers

updateFollowers = (value) ->
  followers = $('.followers-stat').text().trim()
  followers = parseInt followers
  value = parseInt value
  followers = followers + (value)
  $('.followers-stat').text(followers)
