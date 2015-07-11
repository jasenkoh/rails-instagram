# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@INC_FOLLOWERS = 1
@DEC_FOLLOWERS = -1

$(document).ready ->
  id = $('input[name=followed_id]').val()
  $('.relationship-block').on 'click', '.unfollow', ->
    url = API.getRelationshipsUrl().format(id)

    Relationship.editRelationship('DELETE', url).done((result) ->
      updateFollowers DEC_FOLLOWERS, result
    ).fail (result) ->
      console.log result
      alert 'Something bad happened'

  $('.relationship-block').on 'click', '.follow', ->
    url = API.getRelationshipsUrl(true).format(id)

    Relationship.editRelationship('POST',url).done((result) ->
      updateFollowers INC_FOLLOWERS, result
    ).fail (result) ->
      console.log result
      alert 'Something bad happened'

@Relationship = {}

Relationship.editRelationship = (method, url) ->
  $.ajax
    url: url
    type: method

updateFollowers = (value, response) ->
  $('.relationship-block').empty()
  $('.relationship-block').append response
  followers = $('.followers-stat').text().trim()
  followers = parseInt followers
  value = parseInt value
  followers = followers + (value)
  $('.followers-stat').text(followers)
