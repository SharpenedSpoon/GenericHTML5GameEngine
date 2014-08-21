class Robot extends CodebotGameObject

	inCollision = null

	sightRadius = null
	objectsSighted = null

	speed = null



	constructor: (name) ->
		super name

		@color = '#000'
		@width = 10
		@height = 10
		@sightRadius = 40
		@objectsSighted = []

		@collisionGroup = "robot"

		@speed = 10


	awake: () =>
		super
		@stayOnScreen()

	update: (dt) =>
		super dt
		# debug. delete this before production.
		if @keysPressed[KeyCode.W]
			@moveUp()
			@keysPressed[KeyCode.W] = false
		if @keysPressed[KeyCode.A]
			@moveLeft()
			@keysPressed[KeyCode.A] = false
		if @keysPressed[KeyCode.S]
			@moveDown()
			@keysPressed[KeyCode.S] = false
		if @keysPressed[KeyCode.D]
			@moveRight()
			@keysPressed[KeyCode.D] = false

	render: (dt) =>
		@drawSelf()
		@drawSightRadius()

		if @inCollision
			# draws a rectangle around the object
			drawPolygon([
				[@x-0.5, @y-0.5]
				[@x-0.5, @y+@height+0.5]
				[@x+@width+0.5,@y+@height+0.5]
				[@x+@width+0.5,@y-0.5]
			], '#ff0000')
		super dt

	onCollisionEnter: (other) =>
		@inCollision = true

	onCollisionExit: (other) =>
		@inCollision = false
		# check if we are still in a collision
		for collisionBool in @collidedObjects
			if collisionBool
				@inCollision = true
				break


	# ------------------------------------------------------
	# ------------------------------------------------------
	# begin Robot methods to be used for gamelogic

	###
	  # takeTurn:
	  #   called when it is this robot's turn to do something.
	  #   it can only respond to stuff, so it can't set
	  #   any variables. But it can call the rest of the methods
	  #   in this section, and give commands. This can't be
	  #   automatically enforced using JS, but each robot
	  #   may only do one "thing" - there will be a code
	  #   done of each robot before battle, and percieved
	  #   violations of this rule will be dealt with on a
	  #   case by case basis. (i.e. the robot might be
	  #   disqualified and grant an immediate victory to the
	  #   opponent.
	###
	takeTurn: (roundNumber) =>
		# do stuff!


	moveUp: () =>
		@y -= @speed
		@stayOnScreen()
	moveDown: () =>
		@y += @speed
		@stayOnScreen()
	moveRight: () =>
		@x += @speed
		@stayOnScreen()
	moveLeft: () =>
		@x -= @speed
		@stayOnScreen()

	lookAround: () =>
		for o in gameObjects
			o.render(dt) if o.enabled




	# ------------------------------------------------------
	# ------------------------------------------------------
	# generic Robot helper methods

	drawSightRadius: () =>
		drawCircle(@center.x, @center.y, @sightRadius, '#11aa00', false, 3)

	# restricts movement to within the canvas
	stayOnScreen: () =>
		@x = Math.min(canvas.width - @width, Math.max(0, @x))
		@y = Math.min(canvas.height - @height, Math.max(0, @y))
