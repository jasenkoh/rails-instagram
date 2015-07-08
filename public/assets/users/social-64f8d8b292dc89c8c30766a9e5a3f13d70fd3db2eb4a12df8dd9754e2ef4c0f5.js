(function() {
  $(document).ready(function() {
    return $('#peopleModal').on('show.bs.modal', function(event) {
      var button, modal, title;
      button = $(event.relatedTarget);
      title = button.data('title');
      modal = $(this);
      return modal.find('.modal-title').text(title);
    });
  });

}).call(this);
