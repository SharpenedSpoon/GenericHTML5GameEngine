$ () ->
	$(window).on 'keydown', (e) ->
		for o in gameObjects
			o.onKeyDown(e.which) if o.enabled
		return null

	$(window).on 'keyup', (e) ->
		for o in gameObjects
			o.onKeyUp(e.which) if o.enabled
		return null
