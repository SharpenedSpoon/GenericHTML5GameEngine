class Player extends GameObject
	color = null

	maxHealth = null
	hp = null

	keyUp = null
	keyDown = null
	keyLeft = null
	keyRight = null

	keysPressed = null

	constructor: (name) ->
		super name
		@color = "#000000"
		@maxHealth = 10
		@hp = @maxHealth

		@keysPressed = []
		for i in [1..100]
			@keysPressed[i] = false

		@collisionGroup = "player"


	awake: () =>
		@width = 5
		@height = 10
		super

	update: (dt) =>
		hor = 0
		ver = 0
		hor += 1 if @keysPressed[@keyRight]
		hor -= 1 if @keysPressed[@keyLeft]
		ver += 1 if @keysPressed[@keyDown]
		ver -= 1 if @keysPressed[@keyUp]

		@x += hor
		@y += ver

		super dt

	render: (dt) =>
		drawSquare(@x, @y, @width, @height, @color)
		super dt

	onKeyDown: (key) =>
		@keysPressed[key] = true

	onKeyUp: (key) =>
		@keysPressed[key] = false

	onCollision: (other) =>
