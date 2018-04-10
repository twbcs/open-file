
$(document).on('turbolinks:load', function() {
  $('.tag_list .tag.active').click(function() {
    if ($(this).hasClass('active')) {
      var tag = $(this).html();
      var tags = $('#author_tag_names').val();
      $('#author_tag_names').val(tags + ' ' + tag);
      $(this).removeClass('active').removeClass('badge-primary').addClass('badge-secondary');
    }
  });
})
