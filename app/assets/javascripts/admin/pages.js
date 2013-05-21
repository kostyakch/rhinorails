$(function(){
	// Автоматическое разворачивание дополнительных параметров (смотрим куки)
	if( $.cookie('show_params') == 'true') {
		$('.collapse').addClass('in');
		$('.collapse').css('height', 'auto');
		$('#moreless a').text('меньше');
			$('#moreless span').attr('class', 'icon-arrow-up');		
	}

});

// Разворачивание дополнительных параметров
$('.collapse').on('shown', function () {
	$.cookie('show_params', 'true', { path: '/' });
		$('#moreless a').text('меньше');
		$('#moreless span').attr('class', 'icon-arrow-up');
});

// Сворачивание дополнительных параметров
$('.collapse').on('hidden', function () {
	$.cookie('show_params', 'false', { path: '/' });
		$('#moreless a').text('больше');
		$('#moreless span').attr('class', 'icon-arrow-down');
});
