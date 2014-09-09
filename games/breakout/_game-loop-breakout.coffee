gameController = null

createGameObjects = () ->
	gameController = new GameController('game controller')



	p1 = new Player("P1")
	p1.keyUp = KeyCode.W
	p1.keyLeft = KeyCode.A
	p1.keyRight = KeyCode.D
	p1.keyDown = KeyCode.S
	p1.color = "#badcab"

	Debug.Log('created objects')
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
		if o1.enabled && o1.collisionGroup == 'ball'
			o1.fixedUpdate(step)

			# check for collisions with each other object
			for o2 in gameObjects
				oldCollide = false
				newCollide = false
				if o1.collidedObjects[o2.id]
					# js will auto-handle arrays smaller
					# than the index being checked to
					# return 'undefined'
					oldCollide = true

				if o2.enabled && o1 != o2
					# rectangle collision check
					if o1.x >= o2.x && o1.x <= o2.x + o2.width && o1.y >= o2.y && o1.y <= o2.y + o2.height
						newCollide = true
						if ! oldCollide # this is a new collision
							o1.onCollisionEnter(o2)
							#console.log 'collision enter between ' + o1.name + ' and ' + o2.name

				if oldCollide && ! newCollide # the collision ended
					#console.log 'collision exit between ' + o1.name + ' and ' + o2.name
					o1.onCollisionExit(o2)

				# either way, we keep track of the current
				# collision state with other object
				o1.collidedObjects[o2.id] = newCollide
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
