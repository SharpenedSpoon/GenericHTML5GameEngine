###

This gives some standardized methods/variables
that are universal throughout codebot objects

###


class CodebotGameObject extends GameObject

	width = null
	height = null
	color = null
	keysPressed = null
	center = null

	constructor: (name) ->
		super name

		@color = '#000'
		@width = 0
		@height = 0
		@keysPressed = []
		for i in [1..100]
			@keysPressed[i] = false
		@collisionGroup = "codebot"
		@center = {
			x: @x + (0.5 * @width)
			y: @y + (0.5 * @height)
		}


	awake: () =>
		super

	update: (dt) =>
		super dt
		@center = {
			x: @x + (0.5 * @width)
			y: @y + (0.5 * @height)
		}

	render: (dt) =>
		super dt

	onCollisionEnter: (other) =>
		super other

	onCollisionExit: (other) =>
		super other

	onKeyDown: (key) =>
		@keysPressed[key] = true

	onKeyUp: (key) =>
		@keysPressed[key] = false

	# ------------------------------------------------------
	# ------------------------------------------------------
	# begin CodebotGameObject methods

	drawSelf: () =>
		drawSquare(@x, @y, @width, @height, @color)

	# used to give other objects 'public' info
	# about this object in its current state.
	getInfo = () =>
		return {
			name: @name
			x: @x
			y: @y
			width: @width
			height: @height
			collisionGroup: @collisionGroup
		}
