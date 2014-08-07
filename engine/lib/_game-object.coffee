class GameObject

	name = null

	x = null
	y = null

	width = null
	height = null

	id = null

	enabled = null

	collisionGroup = null


	constructor: (name) ->
		@enabled = true
		@collisionGroup = "default"

		@name = name
		@x = 0
		@y = 0
		@width = 0
		@height = 0

		@id = gameObjects.length
		gameObjects.push this

	awake: () =>

	start: () =>

	fixedUpdate: (step) =>

	update: (dt) =>

	render: (dt) =>

	onKeyDown: (key) =>

	onKeyUp: (key) =>

	onCollision: (other) =>
