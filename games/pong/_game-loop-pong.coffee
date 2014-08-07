createGameObjects = () ->
	p1 = new Player("P1")
	p1.keyUp = KeyCode.W
	p1.keyLeft = KeyCode.A
	p1.keyRight = KeyCode.D
	p1.keyDown = KeyCode.S
	p1.color = "#00ff00"

	p2 = new Player("P2")
	p2.keyUp = KeyCode.Up
	p2.keyLeft = KeyCode.Left
	p2.keyRight = KeyCode.Right
	p2.keyDown = KeyCode.Down
	p2.color = "#0000ff"

	ball = new Ball("ball")
	console.log 'hi'
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
	for o in gameObjects
		if o.enabled
			o.fixedUpdate(step)
			for o2 in gameObjects
				if o2.enabled && o != o2
					if o.x >= o2.x && o.x <= o2.x + o2.width && o.y >= o2.y && o.y <= o2.y + o2.height
						o.onCollision(o2)

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



# clear screen function in render is from
# stackoverflow.com/questions/2142535/how-to-clear-the-canvas-for-redrawing)
