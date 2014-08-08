class Player extends GameObject
	color = null

	maxHealth = null
	hp = null

	keyUp = null
	keyDown = null
	keyLeft = null
	keyRight = null

	keysPressed = null

	inCollision = null

	speed = null

	constructor: (name) ->
		super name
		@color = "#000000"
		@maxHealth = 10
		@hp = @maxHealth

		@keysPressed = []
		for i in [1..100]
			@keysPressed[i] = false

		@collisionGroup = "player"

		@inCollision = false

		@speed = 2


	awake: () =>
		@width = 32
		@height = 64
		super

	update: (dt) =>
		hor = 0
		ver = 0
		hor += 1 if @keysPressed[@keyRight]
		hor -= 1 if @keysPressed[@keyLeft]
		ver += 1 if @keysPressed[@keyDown]
		ver -= 1 if @keysPressed[@keyUp]

		@x += hor * @speed
		@y += ver * @speed

		@x = Math.max(0, Math.min(canvas.width, @x))
		@y = Math.max(0, Math.min(canvas.height, @y))

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
