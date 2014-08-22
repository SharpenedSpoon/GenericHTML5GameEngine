class IanRobot extends Robot

	takeTurn: (roundNumber) =>
		# store the previously seen objects
		previousObjectsSighted = @objectsSighted

		# if we don't see anything....
		if @objectsSighted.length == 0
			# look around every 3 turns
			if roundNumber % 3 == 0
				@lookAround()
			else
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
			if dx == 0 && dy == 0
				# we are right on top of them - attack
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
