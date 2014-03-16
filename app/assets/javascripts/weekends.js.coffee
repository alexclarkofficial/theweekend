$ ->
	$('a.load-more-weekends').on 'inview', (e, visible) ->
		return unless visible
	
		$.getScript $(this).attr('href')