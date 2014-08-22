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
		@sightRadius = 80
		@speed = 10
		@objectsSighted = []

		@collisionGroup = "robot"



	awake: () =>
		super
		@stayOnScreen()

	update: (dt) =>
		super dt
		# debug. delete this before production.
		###
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

		if @keysPressed[KeyCode.L]
			@lookAround()
			@keysPressed[KeyCode.L] = false

		if @keysPressed[KeyCode.M]
			@attack()
			@keysPressed[KeyCode.M] = false
		###

	render: (dt) =>
		super dt
		@drawSelf()
		@drawSightRadius()

		context.textAlign = 'center'
		drawText(@center.x, @y + @height + 10, @name )

		if @inCollision
			# draws a rectangle around the object
			drawPolygon([
				[@x-0.5, @y-0.5]
				[@x-0.5, @y+@height+0.5]
				[@x+@width+0.5,@y+@height+0.5]
				[@x+@width+0.5,@y-0.5]
			], '#ff0000')

		# temp function. draw lines to sighted objects
		if @objectsSighted != []
			for o in @objectsSighted
				drawLine(@center.x, @center.y, o.center.x, o.center.y)
				context.globalAlpha = 0.5
				drawSquare(o.x, o.y, o.width, o.height, o.color)
				context.globalAlpha = 1


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
		console.log @name + ' moves up'
		return null
	moveDown: () =>
		@y += @speed
		@stayOnScreen()
		console.log @name + ' moves down'
		return null
	moveRight: () =>
		@x += @speed
		@stayOnScreen()
		console.log @name + ' moves right'
		return null
	moveLeft: () =>
		@x -= @speed
		@stayOnScreen()
		console.log @name + ' moves left'
		return null

	lookAround: () =>
		# clear out any previously spotted objects
		@objectsSighted = []

		for o in gameObjects
			if o.enabled && o != this
				# is the other object within sight radius?
				if @distance(@x, @y, o.x, o.y) < @sightRadius
					# other obj is in range - add its public
					# info to our objectsSighted array
					@objectsSighted.push(o.getInfo())

		console.log @name + ' looks around'
		return null

	attack: () =>
		for o in gameObjects
			if o.enabled && o != this
				# if we're right on top of the other object, kill it
				if @distance(@x, @y, o.x, o.y) < Math.max(@width, @height)
					o.enabled = false
		console.log @name + ' attacks'
		return null



	# ------------------------------------------------------
	# ------------------------------------------------------
	# generic Robot helper methods

	drawSightRadius: () =>
		drawCircle(@center.x, @center.y, @sightRadius, '#11aa00', false, 3)

	# restricts movement to within the canvas
	stayOnScreen: () =>
		@x = Math.min(canvas.width - @width, Math.max(0, @x))
		@y = Math.min(canvas.height - @height, Math.max(0, @y))

	distance: (x1, y1, x2, y2) =>
		return Math.sqrt( Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2) )
