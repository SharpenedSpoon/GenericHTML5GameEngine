createGameObjects = () ->
	#r1 = new Robot("Robot 1")
	f1 = new Flag("Flag 1")

	players = []
	for i in [1..3]
		thisPlayer = new IanRobot("Ian")
		thisPlayer.x = Math.floor(Math.random() * 40) * 10
		thisPlayer.y = Math.floor(Math.random() * 40) * 10

	f1.x = 50
	f1.y = 50
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
	console.log roundNumber
	for o in gameObjects
		if o.collisionGroup == 'robot'
			o.takeTurn(roundNumber)

setInterval(everyoneTakeTurns(), 100)
