$(function() {
  $('#submit').attr('disabled', 'disabled');

  $('#accept_booking').click(function() {
    if ($(this).prop('checked') == false) {
      $('#submit').attr('disabled', 'disabled');
    } else {
      $('#submit').removeAttr('disabled');
    }
  });
});