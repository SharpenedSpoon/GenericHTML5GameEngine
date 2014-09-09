class Player extends GameObject
	color = null

	maxHealth = null
	hp = null

	keyUp = null
	keyDown = null
	keyLeft = null
	keyRight = null
	keyShoot = null

	keysPressed = null

	inCollision = null

	speed = null
	jumpSpeed = null

	velocity = null

	onGround = null

	constructor: (name) ->
		@width = 32
		@height = 64

		@color = "#000000"
		@maxHealth = 10
		@hp = @maxHealth

		@keysPressed = []
		for i in [1..100]
			@keysPressed[i] = false

		@collisionGroup = "player"

		@inCollision = false

		@speed = 2
		@jumpSpeed = -20

		@velocity = {
			x: 0
			y: 0
			dx: 0
			dy: 0
		}

		@onGround = false

		super name


	awake: () =>
		super

	update: (dt) =>
		if checkCollisionWithGroup("wall", @x, @y + 0.5, @width, @height)
			#if ! @onGround
				# we just landed
				#@velocity.y = 0
			@onGround = true
		else
			@onGround = false


		hor = 0
		ver = 0
		hor += 1 if @keysPressed[@keyRight]
		hor -= 1 if @keysPressed[@keyLeft]
		ver += 1 if @keysPressed[@keyDown]
		ver -= 1 if @keysPressed[@keyUp]

		@velocity.x = (hor * @speed)

		if ver == -1 && @onGround
			@velocity.y = @jumpSpeed

		if ! @onGround
			@velocity.y += gravity

		@move()

		super dt

	render: (dt) =>
		drawSquare(@x, @y, @width, @height, @color)
		if @inCollision
			drawPolygon([
				[@x-0.5, @y-0.5]
				[@x-0.5, @y+@height+0.5]
				[@x+@width+0.5,@y+@height+0.5]
				[@x+@width+0.5,@y-0.5]
			], '#ff0000')
		super dt

	onKeyDown: (key) =>
		@keysPressed[key] = true

	onKeyUp: (key) =>
		@keysPressed[key] = false

	onCollisionEnter: (other) =>
		@inCollision = true

	onCollisionExit: (other) =>
		@inCollision = false
		# check if we are still in a collision
		for collisionBool in @collidedObjects
			if collisionBool
				@inCollision = true
				break


	# -----------------------------------------------------
	# End built in functions. begin player functions
	# -----------------------------------------------------
	move: () =>
		# add previous non integer valued parts
		if Math.abs(@velocity.dx) >= 1
			@velocity.x += @velocity.dx
			@velocity.dx = 0

		# move pixel by pixel as long as (or until) we don't collide
		i = 0
		xDir = 0
		xDir = 1 if @velocity.x > 0
		xDir = -1 if @velocity.x < 0
		if xDir != 0
			@velocity.x = Math.abs(@velocity.x)
			while i < @velocity.x
				if ! checkCollision(this, @x + xDir, @y, @width, @height)
					@x += xDir
				i++
			# make the velocity integer valued
			@velocity.dx += xDir * (@velocity.x - Math.floor(@velocity.x))
			@velocity.x = xDir * Math.floor(@velocity.x)


		i = 0
		yDir = 0
		yDir = 1 if @velocity.y > 0
		yDir = -1 if @velocity.y < 0
		if yDir != 0
			@velocity.y = Math.abs(@velocity.y)
			while i < @velocity.y
				if ! checkCollision(this, @x, @y + yDir, @width, @height)
					@y += yDir
				i++
			# make the velocity integer valued
			@velocity.dy += yDir * (@velocity.y - Math.floor(@velocity.y))
			@velocity.y = yDir * Math.floor(@velocity.y)
		#@x += hor * @speed
		#@y += ver * @speed

		#@x = Math.max(0, Math.min(canvas.width, @x))
		#@y = Math.max(0, Math.min(canvas.height, @y))
