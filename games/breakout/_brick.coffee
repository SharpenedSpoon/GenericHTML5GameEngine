class Brick extends GameObject

	color = null

	constructor: (name) ->
		@color = '#abc123'
		@collisionGroup = 'brick'
		super name

	awake: () =>
		super

	update: (dt) =>
		super dt

	render: (dt) =>
		drawSquare(@x, @y, @width, @height, '#000')
		drawSquare(@x + 1, @y + 1, @width - 2, @height - 2, @color)
		super dt

	destroy: () =>
		gameController.addScore(100)
		@enabled = false
