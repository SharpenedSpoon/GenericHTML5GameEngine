class Wall extends GameObject

	constructor: (name) ->
		@collisionGroup = "wall"
		@width = 32
		@height = 32

		@color = "#badcab"
		super name


	render: (dt) =>
		#super dt
		drawSquare(@x, @y, @width, @height, @color)
		return null
