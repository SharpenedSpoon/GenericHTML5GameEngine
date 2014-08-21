class Flag extends CodebotGameObject

		inCollision = null

		speed = null

		constructor: (name) ->
			super name

			@color = '#aa0000'
			@width = 10
			@height = 10

			@collisionGroup = "flag"

			@speed = 10


		awake: () =>
			super
			@stayOnScreen()

		update: (dt) =>
			super dt
			# debug. delete this before production.
			if @keysPressed[KeyCode.Up]
				@moveUp()
				@keysPressed[KeyCode.Up] = false
			if @keysPressed[KeyCode.Left]
				@moveLeft()
				@keysPressed[KeyCode.Left] = false
			if @keysPressed[KeyCode.Down]
				@moveDown()
				@keysPressed[KeyCode.Down] = false
			if @keysPressed[KeyCode.Right]
				@moveRight()
				@keysPressed[KeyCode.Right] = false


		render: (dt) =>
			super dt
			@drawSelf()



		# ------------------------------------------------------
		# ------------------------------------------------------
		# begin flag methods to be used for gamelogic


		moveUp: () =>
			@y -= @speed
			@stayOnScreen()
			return null
		moveDown: () =>
			@y += @speed
			@stayOnScreen()
			return null
		moveRight: () =>
			@x += @speed
			@stayOnScreen()
			return null
		moveLeft: () =>
			@x -= @speed
			@stayOnScreen()
			return null

		# restricts movement to within the canvas
		stayOnScreen: () =>
			@x = Math.min(canvas.width - @width, Math.max(0, @x))
			@y = Math.min(canvas.height - @height, Math.max(0, @y))
