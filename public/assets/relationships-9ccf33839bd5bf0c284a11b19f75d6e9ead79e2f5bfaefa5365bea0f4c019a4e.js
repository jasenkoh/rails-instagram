(function() {
  var DEC_FOLLOWERS, INC_FOLLOWERS, editRelationship, updateFollowers;

  INC_FOLLOWERS = 1;

  DEC_FOLLOWERS = -1;

  $(document).ready(function() {
    var id;
    id = $('input[name=followed_id]').val();
    $('.relationship-block').on('click', '.unfollow', function() {
      return editRelationship(id, 'DELETE', "relationships/" + id, DEC_FOLLOWERS);
    });
    return $('.relationship-block').on('click', '.follow', function() {
      return editRelationship(id, 'POST', "relationships?followed_id=" + id, INC_FOLLOWERS);
    });
  });

  editRelationship = function(id, method, url, followers) {
    return $.ajax({
      url: url,
      type: method,
      dataType: 'json',
      success: function(data) {
        return console.log(data);
      },
      complete: function(data) {
        if (data.status === 200) {
          $('.relationship-block').empty();
          $('.relationship-block').append(data.responseText);
          return updateFollowers(followers);
        }
      }
    });
  };

  updateFollowers = function(value) {
    var followers;
    followers = $('.followers-stat').text().trim();
    followers = parseInt(followers);
    value = parseInt(value);
    followers = followers + value;
    return $('.followers-stat').text(followers);
  };

}).call(this);
