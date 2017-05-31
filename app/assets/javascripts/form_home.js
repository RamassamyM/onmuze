$(document).ready(function() {
  $('#search-alert').hide();
  $('#btn-home').click(function(e) {
    if ($('#performance_address').val() === '' || $('#performance_date').val() === '' || $('#performance_event_type').val() === '') {
      $('#search-alert').show(500);
      e.preventDefault();
    } else {
      $('#search-alert').hide(500);
      $(this).unbind('click');
    }
  });
});
