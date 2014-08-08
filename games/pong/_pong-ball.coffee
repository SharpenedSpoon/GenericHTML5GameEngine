

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
		if @y > canvas.height || @y < 0
			@velocity.y = -1 * @velocity.y
			@y = Math.min(canvas.height, Math.max(0, @y))

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
		if other.collisionGroup == 'player'
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
			debugText = 'Collision: ' + @name + ' <-> ' + other.name + ' ';

			# figure out where the other object is
			if centerOther.x <= center.x # other object is to the left
				horizCollision = true
				debugText += '...on left '
			if centerOther.x >= center.x # other object is to the right
				horizCollision = true
				debugText += '...on right '
			if centerOther.y <= center.y # other object is to the top
				vertCollision = false
				debugText += '...on top '
			if centerOther.y >= center.y # other object is to the bottom
				vertCollision = false
				debugText += '...on bottom '

			# if both types of collisions were found, determine
			# if one were more predominant
			if horizCollision && vertCollision
				# if we backed off the horizontal would we still
				# have a horizontal collision? If so, that's bad.
				# which means that this should only be a vertical
				# collision
				if @x - velocity.x >= other.x && @x - velocity.x <= other.x + other.width
					horizCollision = false
					debugText += '...got rid of horiz '

				if @y - velocity.y >= other.y && @y - velocity.y <= other.y + other.height
					vertCollision = false
					debugText += '...got rid of vert '

				# sanity check: if we just got rid of both the
				# horiz and the vert collisions, then let's just
				# put them both back and assume (or at leas pretend)
				# it's a diagonal collision.
				if ! horizCollision && ! vertCollision
					horizCollision = true
					vertCollision = true
					debugText += '...got rid of too many things- put it back put it back oh shhiiiiiii'

			console.log debugText
			paused = true


			@velocity.x *= -1 if horizCollision
			@velocity.y *= -1 if vertCollision
		return null

	onCollisionExit: (other) =>
