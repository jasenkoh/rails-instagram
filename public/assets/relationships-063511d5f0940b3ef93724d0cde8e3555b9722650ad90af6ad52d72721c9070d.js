(function() {
  var editRelationship;

  $(document).ready(function() {
    var id;
    id = $('input[name=followed_id]').val();
    $('.relationship-block').on('click', '.unfollow', function() {
      return editRelationship(id, 'DELETE', "relationships/" + id);
    });
    return $('.relationship-block').on('click', '.follow', function() {
      return editRelationship(id, 'POST', "relationships?followed_id=" + id);
    });
  });

  editRelationship = function(id, method, url) {
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
          return $('.relationship-block').append(data.responseText);
        }
      }
    });
  };

}).call(this);
