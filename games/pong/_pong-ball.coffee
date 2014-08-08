

class Ball extends GameObject

	velocity = null

	lastPositions = null


	constructor: (name) ->
		super name
		@collisionGroup = "ball"
		@velocity = {x: 1, y: 1}

		@name = name
		@x = 50
		@y = 50
		@width = 4
		@height = 4

		@color = "#000011"

		lastPositions = []

	awake: () =>
		super

	start: () =>
		super

	fixedUpdate: (step) =>
		super step

	update: (dt) =>
		lastPositions.unshift {x: @x, y: @y}
		if lastPositions.length > 100
			lastPositions.pop()

		@x += (@velocity.x)
		@y += (@velocity.y)

		if @x > canvas.width || @x < 0
			@velocity.x = -1 * @velocity.x
			@x = Math.min(canvas.width, Math.max(0, @x))
		if @y > canvas.height || @y < 0
			@velocity.y = -1 * @velocity.y
			@y = Math.min(canvas.height, Math.max(0, @y))
		super dt

	render: (dt) =>
		drawSquare(@x, @y, @width, @height, @color)

		for pos, i in lastPositions
			drawSquare pos.x, pos.y, @width, @height, "rgba(0,0,0," + ((lastPositions.length - i)/lastPositions.length) + ")"
		super dt

	onKeyDown: (key) =>

	onKeyUp: (key) =>

	onCollisionEnter: (other) =>

	onCollisionExit: (other) =>
