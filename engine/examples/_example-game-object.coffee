###

This is an example of a game object extension.
It must have all the listed methods and each
method must call its parent method.

There are some example fields and example
game logic in some methods. delete it all! it's
just meant to be an example.

Similarly, basic collision logic is included in this
example since it is so common in many games. You
may want to just delete all of it. Same with
key press logic.


###

class ExampleGameObject extends GameObject

	# these are just example fields. delete them!
	customField = null
	startX = null
	width = null
	height = null
	keysPressed = null
	inCollision = null


	constructor: (name) ->
		super name
		@customField = "some value"
		@keysPressed = []
		for i in [1..100]
			@keysPressed[i] = false

	awake: () =>
		@startX = @x
		@width = 32
		@height = 32
		super

	update: (dt) =>
		@x = @x + 1
		super dt

	render: (dt) =>
		drawSquare(@x, @y, @width, @height, "#abc123")
		if @inCollision
			# draws a rectangle around the object
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
