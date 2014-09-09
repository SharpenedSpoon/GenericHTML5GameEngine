# @codekit-prepend "../../engine/_engine.coffee";
# @codekit-prepend "_utility-functions.coffee";
# @codekit-prepend "_game-loop-ssd.coffee";
# @codekit-prepend "_player-object.coffee";
# @codekit-prepend "_pong-ball.coffee";
# @codekit-prepend "_wall.coffee";

players = []

$ () ->
	$('body').on 'keyup', (e) ->
		if e.which == KeyCode.T
			pl = new Player "Player"
			console.log pl
			pl.color = "#ffff00"
			players.push pl
			pl.keyUp = KeyCode.W
			pl.keyLeft = KeyCode.A
			pl.keyRight = KeyCode.D
			pl.keyDown = KeyCode.S
