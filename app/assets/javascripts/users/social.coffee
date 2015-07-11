# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#peopleModal').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)
    title = button.data('title')

    id = $('input[name=followed_id]').val()

    modal = $(this)
    modal.find('.modal-title').text(title)
    if title is 'Followers'
      Social.getConnectedPeople API.getFollowerUrl().format(id), success
    else
      Social.getConnectedPeople API.getFollowingUrl().format(id), success

  $('.connected-people').on 'click', '.follow', (event), ->
    id = $(this).parent().data('id')
    url = API.getRelationshipsUrl(true).format(id)
    element = $(this).parent()

    Relationship.editRelationship('POST', url).done((response) ->
      element.find('.follow').remove()
      element.append response
    ).fail (response) ->
      console.log response
      alert 'Something bad happened'

  $('.connected-people').on 'click', '.unfollow', (event), ->
    id = $(this).parent().data('id')
    url = API.getRelationshipsUrl().format(id)
    element = $(this).parent()

    Relationship.editRelationship('DELETE', url).done((response) ->
      element.find('.unfollow').remove()
      element.append response
    ).fail (response) ->
      console.log response
      alert 'Something bad happened'

success = (response) ->
  $('.connected-people').empty()
  $.each response, (_, value) ->
    link = ''
    if value.following
      link = "<button class='btn btn-success unfollow'>Unfollow</button>"
    else
      link = "<button class='btn btn-warning follow'>Follow</button>"

    html = "<div class='clearfix'>
      <img src=#{value.avatar} />
      <a href='/#{value.username}'>#{value.username}</a>
      </div>"
    $(html).find('div').append(link)

    $('.connected-people').append($("<div class='clearfix' data-id=#{value.id}>")
      .append($("<img src=#{value.avatar} />"))
      .append($("<a href='/#{value.username}'>")
      .append(("#{value.username}")))
      .append($(link) if User.getId() and value.id isnt User.getId())
      )

@Social = {}

Social.getConnectedPeople = (url, onSuccess) ->
  $.ajax
    url: url
    success: onSuccess
    error: ->
      alert 'Opps! Please try again.'
