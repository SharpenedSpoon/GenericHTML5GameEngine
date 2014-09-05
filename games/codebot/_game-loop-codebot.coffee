createGameObjects = () ->
	f1 = new Flag("Flag 1")

	# Spawn players
	#austin = new TMGBot("Austin" + i)
	#kyle = new KyleRobot("Kyle" + i)
	ian = new IanRobot("Ian" + i)
	#timmy = new TimmyRobot("Timmy" + i)
	ian.color = '#aa00aa'
	#timmy.color = '#185F7F'
	#austin.color = '#3dad3d'
	#kyle.color = '#660202'

	# player colors



	# spawning and shuffling positions
	gameObjects = shuffle(gameObjects)

	spawnArea = {
		width: (canvas.width) / 4
		height: (canvas.height) / 4
	}
	row = 0
	col = 0
	for o in gameObjects
		#o.x = Math.floor(((Math.random() * spawnArea.width) + (row * spawnArea.width)) / 10) * 10
		#o.y = Math.floor(((Math.random() * spawnArea.height) + (col * spawnArea.height)) / 10) * 10
		o.x = Math.floor((Math.random() * canvas.width) / 10) * 10
		o.y = Math.floor((Math.random() * canvas.height) / 10) * 10

		GameLog('Spawning ' + o.name + ' at (' + o.x + ',' + o.y + ')')
	return null

awake = () ->
	for o in gameObjects
		o.awake() if o.enabled
	return null

start = () ->
	for o in gameObjects
		o.start() if o.enabled
	return null

update = (dt) ->
	for o in gameObjects
		o.update(dt) if o.enabled
	return null

fixedUpdate = (step) ->
	oldCollide = false
	for o1 in gameObjects
		if o1.enabled
			o1.fixedUpdate(step)

	return null

render = (dt) ->
	# ----- first clear screen for redrawing
	# store transformation matrix
	context.save()

	# use ident matrix while clearing canvas
	context.setTransform(1, 0, 0, 1, 0, 0)
	context.clearRect(0, 0, canvas.width, canvas.height)

	# restore transform
	context.restore()

	# ----- render all gameObjects
	for o in gameObjects
		o.render(dt) if o.enabled
	return null


roundNumber = 0

$(window).on 'keyup', (e) ->
	if e.which == KeyCode.Space
		everyoneTakeTurns()
	return null


everyoneTakeTurns = () ->
	roundNumber++
	$('#round-number').html(roundNumber)
	console.log roundNumber
	for o in gameObjects
		if o.collisionGroup == 'robot' && o.enabled
			o.takeTurn(roundNumber)

everyoneTakeRegularTurns = () ->
	intervalLength = parseInt($('#interval-length').val())
	if document.getElementById('game-running').checked
		everyoneTakeTurns()
	setTimeout(everyoneTakeRegularTurns, intervalLength)

$ () -> everyoneTakeRegularTurns()


GameLog = (txt) -> $('#game-log').append('<li>Round ' + roundNumber + ': ' + txt + '</li>')



# from http://coffeescriptcookbook.com/chapters/arrays/shuffling-array-elements
shuffle = (a) ->
	# From the end of the list to the beginning, pick element `i`.
	for i in [a.length-1..1]
		# Choose random element `j` to the front of `i` to swap with.
		j = Math.floor Math.random() * (i + 1)
		# Swap `j` with `i`, using destructured assignment
		[a[i], a[j]] = [a[j], a[i]]
	# Return the shuffled array.
	a
