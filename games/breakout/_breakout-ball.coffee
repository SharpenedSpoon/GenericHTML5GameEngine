

class Ball extends GameObject

	velocity = null

	lastPositions = null


	constructor: (name) ->
		super name
		@collisionGroup = "ball"
		@velocity = {x: 2, y: -2}

		@name = name
		@x = canvas.width / 2
		@y = canvas.height - 50
		@width = 4
		@height = 4

		@color = "#000011"

		lastPositions = []

	awake: () =>
		#super

	start: () =>
		#super

	fixedUpdate: (step) =>
		#super step

	update: (dt) =>
		#super dt
		lastPositions.unshift {x: @x, y: @y}
		if lastPositions.length > 100
			lastPositions.pop()

		@x += (@velocity.x)
		@y += (@velocity.y)

		if @x > canvas.width || @x < 0
			@velocity.x = -1 * @velocity.x
			@x = Math.min(canvas.width, Math.max(0, @x))
		if @y < 0
			@velocity.y = -1 * @velocity.y
			@y = Math.min(canvas.height, Math.max(0, @y))

		if @y > canvas.height
			gameController.reset()

	render: (dt) =>
		#super dt
		drawSquare(@x, @y, @width, @height, @color)

		for pos, i in lastPositions
			drawSquare pos.x, pos.y, @width, @height, "rgba(0,0,0," + ((lastPositions.length - i)/lastPositions.length) + ")"
		return null

	onKeyDown: (key) =>

	onKeyUp: (key) =>

	onCollisionEnter: (other) =>
		horizCollision = false
		vertCollision = false
		if other.collisionGroup == 'player' || other.collisionGroup == 'brick'
			# figure out what direction the collision came from
			# That is, figure out where the other object is
			# - to the left of curr obj, or to right, or..?
			#
			# ...making this a little moreverbose than I normally
			# would, just for clarity for future games
			#
			# Honestly I'm not sure if this is the best way.
			# ...or if this even works most of the time!
			# I'm kinda swinging blind here. Let's do it!
			#
			halfSize = {
				width: 0.5 * @width
				height: 0.5 * @height
			}
			halfSizeOther = {
				width: 0.5 * other.width
				height: 0.5 * other.height
			}
			center = {
				x: @x + halfSize.width
				y: @y + halfSize.height
			}
			centerOther = {
				x: other.x + halfSizeOther.width
				y: other.y + halfSizeOther.height
			}
			anglesOther = {
				topLeft:     Math.atan2(halfSizeOther.height, -1 * halfSizeOther.width)
				topRight:    Math.atan2(halfSizeOther.height, halfSizeOther.width)
				bottomRight: Math.atan2(-1 * halfSizeOther.height, halfSizeOther.width)
				bottomLeft:  Math.atan2(-1 * halfSizeOther.height, -1 * halfSizeOther.width)
			}
			console.log anglesOther
			debugText = 'Collision: ' + @name + ' <-> ' + other.name + ' ';

			collisionSide = ''
			angle = Math.atan2(centerOther.y - center.y, centerOther.x - center.x)
			debugText += '...angle: ' + angle + ' '
			piFourths = 0.25 * Math.PI
			if angle >= anglesOther.bottomRight && angle < anglesOther.topRight
				horizCollision = true
				debugText += '...on right '
				collisionSide = 'right'
			else if angle >= anglesOther.topRight && angle < anglesOther.topLeft
				vertCollision = true
				debugText += '...on top '
				collisionSide = 'top'
			else if angle >= anglesOther.bottomLeft && angle < anglesOther.bottomRight
				vertCollision = true
				debugText += '...on bottom '
				collisionSide = 'bottom'
			else if angle >= anglesOther.topLeft || angle < anglesOther.bottomLeft
				horizCollision = true
				debugText += '...on left '
				collisionSide = 'left'


			console.log debugText
			#paused = true


			@velocity.x *= -1 if horizCollision
			@velocity.y *= -1 if vertCollision

		if other.collisionGroup == 'brick'
			other.destroy()

		return null

	onCollisionExit: (other) =>
