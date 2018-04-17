
$(document).on('turbolinks:load', function() {
  $('.tag_list .tag.active').click(function() {
    if ($(this).hasClass('active')) {
      var tag = $(this).html();
      var tags = $('#author_tag_names').val();
      $('#author_tag_names').val(tags + ' ' + tag);
      $(this).removeClass('active').removeClass('badge-primary').addClass('badge-secondary');
    }
  });
  $('.alert').alert();

  $('.star div').mouseenter(function(){
    if (!$(this).parent().parent().parent().hasClass('show')) {
      var level = $(this).data('star');
      var id =  $(this).parent().parent().parent().attr('id');
      $('#' + id + ' .star div').each(function() {
        if ($(this).data('star') <= level) {
          $(this).addClass('hover');
        } else {
          $(this).removeClass('hover');
        }
      });
    }
  }).mouseleave(function() {
    if (!$(this).parent().parent().parent().hasClass('show')) {
      var level = $(this).parent().parent().parent().data('rating');
      var id =  $(this).parent().parent().parent().attr('id');
      $('#' + id + ' .star div').each(function() {
        if ($(this).data('star') <= level) {
          $(this).addClass('hover');
        } else {
          $(this).removeClass('hover');
        }
      });
    }
  }).click(function() {
    var level = $(this).data('star');
    $(this).parent().parent().parent().data('rating', level);
  });
});
