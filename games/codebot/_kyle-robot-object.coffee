class KyleRobot extends Robot

	# MY LOVE FOR YOU IS TICKING CLOCK BERSERKER
	takeTurn: (roundNumber) =>
		# store the previously seen objects
		previousObjectsSighted = @objectsSighted

		# look around every 3 turns
		if roundNumber % 3 == 0
			@lookAround()
		else
			if @objectsSighted.length == 0
				# if we don't see anything....
				if (@center.x) < (6 + (@sightRadius/2))
					@moveRight()
				else if (@center.x) > (canvas.width - (6 + (@sightRadius/2)))
					@moveLeft()
				else if (@center.y) < (6 + (@sightRadius/2))
					@moveDown()
				else if (@center.y) > (canvas.height - (6 + (@sightRadius/2)))
					@moveUp()
				else
					# slope = canvas.height / canvas.width
					# if (@center.y / @center.x) < slope
					# 	@moveUp()
					# else if (@center.y / @center.x) > slope
					# 	@moveDown()
					# else
					randDir = [1, 2, 3, 4]
					randDir = randDir[Math.floor(Math.random() * randDir.length)]
					switch randDir
						when 1 then @moveUp()
						when 2 then @moveRight()
						when 3 then @moveDown()
						when 4 then @moveLeft()
			else
				# we have someone in sight
				dx = @objectsSighted[0].x - @x
				dy = @objectsSighted[0].y - @y
				distanceToEnemy = @distance(@x, @y, @objectsSighted[0].x, @objectsSighted[0].y)
				console.log("distance to enemy: ", distanceToEnemy)
				console.log("distance to enemy (x): ", dx)
				console.log("distance to enemy (y): ", dy)

				if dx == 0 && dy == 0
					# we are right on top of them - attack
					@attack()
				else if @objectsSighted[0].collisionGroup == "robot" && (Math.abs(dy) == 10 || Math.abs(dx) == 10)
					# if we start dancing, stop and wait for kill move
					console.log('waiting to kill')
					@attack()
				else if Math.abs(dy) > Math.abs(dx)
					if dy > 0
						@moveDown()
					else if dy < 0
						@moveUp()
				else
					if dx > 0
						@moveRight()
					else if dx < 0
						@moveLeft()


		return null
