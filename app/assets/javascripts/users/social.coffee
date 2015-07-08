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
      Social.getConnectedPeople User.getId, API.getFollowerUrl().format(id), success
    else
      Social.getConnectedPeople User.getId, API.getFollowingUrl().format(id), success

success = (response) ->
  $('.connected-people').empty()
  $.each response, (_, value) ->
    link = ''
    if value.following
      link = "<button class='pull-right btn btn-success unfollow'>Unfollow</button>"
    else
      link = "<button class='pull-right btn btn-warning follow'>Follow</button>"

    html = "<div class='clearfix'>
      <img src=#{value.avatar} />
      <a href='/#{value.username}'>#{value.username}</a>
      </div>"
    $(html).find('div').append(link)

    $('.connected-people').append($("<div class='clearfix'>")
      .append($("<img src=#{value.avatar} />"))
      .append($("<a href='/#{value.username}'>")
      .append(("#{value.username}")))
      .append($(link) if value.id isnt User.getId())
      )

@Social = {}

Social.getConnectedPeople = (userId, url, onSuccess) ->
  $.ajax
    url: url
    success: onSuccess
