String::format = ->
  formatted = this
  i = 0
  while i < arguments.length
    regexp = new RegExp('\\{' + i + '\\}', 'gi')
    formatted = formatted.replace(regexp, arguments[i])
    i++
  formatted

@API = {}

API.getFollowerUrl = ->
  'users/{0}/followers.json'

API.getFollowingUrl = ->
  'users/{0}/following.json'
API.getRelationshipsUrl = (param) ->
  if param != undefined then 'relationships?followed_id={0}' else 'relationships/{0}'
