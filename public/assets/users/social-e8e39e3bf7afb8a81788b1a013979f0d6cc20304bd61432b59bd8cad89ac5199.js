(function() {
  var success;

  $(document).ready(function() {
    return $('#peopleModal').on('show.bs.modal', function(event) {
      var button, id, modal, title;
      button = $(event.relatedTarget);
      title = button.data('title');
      id = $('input[name=followed_id]').val();
      modal = $(this);
      modal.find('.modal-title').text(title);
      if (title === 'Followers') {
        return Social.getConnectedPeople(User.getId, API.getFollowerUrl().format(id), success);
      } else {
        return Social.getConnectedPeople(User.getId, API.getFollowingUrl().format(id), success);
      }
    });
  });

  success = function(response) {
    $('.connected-people').empty();
    return $.each(response, function(_, value) {
      var html, link;
      link = '';
      if (value.following) {
        link = "<button class='pull-right btn btn-success unfollow'>Unfollow</button>";
      } else {
        link = "<button class='pull-right btn btn-warning follow'>Follow</button>";
      }
      html = "<div class='clearfix'> <img src=" + value.avatar + " /> <a href='/" + value.username + "'>" + value.username + "</a> </div>";
      $(html).find('div').append(link);
      return $('.connected-people').append($("<div class='clearfix'>").append($("<img src=" + value.avatar + " />")).append($("<a href='/" + value.username + "'>").append("" + value.username)).append(value.id !== User.getId() ? $(link) : void 0));
    });
  };

  this.Social = {};

  Social.getConnectedPeople = function(userId, url, onSuccess) {
    return $.ajax({
      url: url,
      success: onSuccess
    });
  };

}).call(this);
