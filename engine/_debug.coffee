Debug = {
	getTime: () ->
		now = new Date()
		now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds()
	Log: (txt) ->
		oldHtml = $('#debug').html()
		oldHtml = oldHtml + '<br/>' if oldHtml != ''
		$('#debug').html oldHtml + @getTime() + ' - ' + txt
}
