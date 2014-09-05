class GameObject

	name = null

	x = null
	y = null

	width = null
	height = null

	id = null

	enabled = null

	collisionGroup = null

	collidedObjects = null


	constructor: (name) ->
		@enabled = @enabled || true
		@collisionGroup = @collisionGroup || "default"

		@name = name
		@x = @x || 0
		@y = @y || 0
		@width = @width || 0
		@height = @height || 0

		@collidedObjects = @collidedObjects || []

		@id = gameObjects.length
		gameObjects.push this

		if gameStarted
			@awake()
			@start()

	awake: () =>

	start: () =>

	fixedUpdate: (step) =>

	update: (dt) =>

	render: (dt) =>

	onKeyDown: (key) =>

	onKeyUp: (key) =>

	onCollisionEnter: (other) =>

	onCollisionExit: (other) =>
