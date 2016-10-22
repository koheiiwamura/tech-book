$(function() {
  $('#submit').attr('disabled', 'disabled');

  $('#accept_booking').click(function() {
    if ($(this).prop('checked') == false) {
      $('#submit').attr('disabled', 'disabled').removeClass('btn-primary');
    } else {
      $('#submit').removeAttr('disabled').addClass('btn-primary');
    }
  });
});

$(function() {
  if ($('#comment_text').val().replace(/[\n\s　]/g, "").length == 0) {
    $('#submit').attr('disabled', 'disabled');
  }
  $('#comment_text').bind('keydown keyup keypress change', function() {
    if ($(this).val().replace(/[\n\s　]/g, "").length > 0) {
      $('#submit').removeAttr('disabled').addClass('btn-primary');
    } else {
      $('#submit').attr('disabled', 'disabled').removeClass('btn-primary');
    }
  });
});