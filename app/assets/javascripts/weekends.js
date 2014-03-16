$(function() {
  return $('a.load-more-weekends').bind('inview', function(e, visible) {
    if (!visible) {
      return;
    }
    $.getScript($(this).attr('href'));
  });
});
