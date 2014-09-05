class TMGBot extends Robot

	takeTurn: (roundNumber) =>
		# store the previously seen objects
		previousObjectsSighted = @objectsSighted

		borderLeft = @sightRadius
		borderRight = canvas.width - @sightRadius
		borderTop = @sightRadius
		borderBottom = canvas.width - @sightRadius

		centerX = (borderLeft + borderRight)/2
		centerY = (borderTop + borderBottom)/2

		# look around every 3 turns
		if roundNumber % 5 == 0
			# console.log("LOOK AROUND")
			@lookAround()
		else
			flagFound = false
			for foreignItem in @objectsSighted
				if foreignItem.collisionGroup == 'flag'
					flagFound = true
					flagObject = foreignItem
			if flagFound
				if @x - flagObject.x > 0
					@moveLeft()
				else if @x - flagObject.x < 0
					@moveRight()
				else if @y - flagObject.y > 0
					@moveUp()
				else if @y - flagObject.y < 0
					@moveDown()
				else
					@attack()
			else
				@defaultMove(roundNumber)

			# if @objectsSighted.length == 0
			# 	# if we don't see anything....
			# 	@defaultMove(roundNumber)
			# else
			# 	# we have someone in sight
			# 	dx = @objectsSighted[0].x - @x
			# 	dy = @objectsSighted[0].y - @y
			# 	if dx == 0 && dy == 0
			# 		# we are right on top of them - attack
			# 		@attack()
			# 	else if Math.abs(dy) > Math.abs(dx)
			# 		if dy > 0
			# 			@moveDown()
			# 		else if dy < 0
			# 			@moveUp()
			# 	else
			# 		if dx > 0
			# 			@moveRight()
			# 		else if dx < 0
			# 			@moveLeft()
			#

		return null

	defaultMove: (roundNumber) =>

		borderLeft = @sightRadius/2
		borderRight = canvas.width - @sightRadius/2
		borderTop = @sightRadius/2
		borderBottom = canvas.height - @sightRadius/2

		centerX = (borderLeft + borderRight)/2
		centerY = (borderTop + borderBottom)/2

		if @x >= centerX-10 && @x <= centerX+10 && @y >= centerY-10 && @y <= centerY+10
			# console.log("CENTER");
			randDir = [1, 2, 3, 4]
			randDir = randDir[Math.floor(Math.random() * randDir.length)]
			switch randDir
				when 1 then @moveUp()
				when 2 then @moveRight()
				when 3 then @moveDown()
				when 4 then @moveLeft()

		else if @x >= (centerX-10) && @x <= (centerX+10)
			# console.log("PRIME MERIDIAN")
			if @y > borderTop && @y < centerY
				# console.log("UP")
				@moveUp()
			else if @y < borderBottom && @y > centerY
				# console.log("DOWN")
				@moveDown()
			else
				# console.log("RIGHT/LEFT")
				randDir = [1, 2]
				randDir = randDir[Math.floor(Math.random() * randDir.length)]
				switch randDir
					when 1 then @moveLeft()
					when 2 then @moveRight()

		else if @y >= centerY-10 && @y <= centerY+10
			# console.log("EQUATOR")
			if @x < borderRight && @x > centerX
				# console.log("RIGHT")
				@moveRight()
			else if @x > borderLeft && @x < centerX
				# console.log("LEFT")
				@moveLeft()
			else
				# console.log("UP/DOWN")
				randDir = [1, 2]
				randDir = randDir[Math.floor(Math.random() * randDir.length)]
				switch randDir
					when 1 then @moveUp()
					when 2 then @moveDown()

		# else if @x == borderLeft && @y >= (borderTop + 5)
		# 	@moveRight()
		# else if @x == borderLeft && @y <= (borderBottom - 5)
		# 	@moveRight()
		# else if @x == borderRight && @y >= (borderTop + 5)
		# 	@moveLeft()
		# else if @x == borderRight && @y <= (borderBottom - 5)
		# 	@moveLeft()
		#
		# else if @y == borderTop && @x >= (borderLeft + 5)
		# 	@moveDown()
		# else if @y == borderTop && @x <= (borderRight - 5)
		# 	@moveDown()
		# else if @y == borderBottom && @x >= (borderLeft + 5)
		# 	@moveUp()
		# else if @y == borderBottom && @x <= (borderRight - 5)
		# 	@moveUp()

		else if @x <= borderLeft
			# console.log(" Left Border Meridian")
			if @y < (borderTop + 20) || @y > borderBottom - 20
				# console.log("RIGHT")
				@moveRight()
			else if @y < centerY && @y > borderTop
				# console.log("UP")
				@moveUp()
			else if @y > centerY && @y < borderBottom
				# console.log("DOWN")
				@moveDown()
			else
				randDir = [1, 2]
				randDir = randDir[Math.floor(Math.random() * randDir.length)]
				switch randDir
					when 1 then @moveUP()
					when 2 then @moveDown()

		else if @x >= borderRight
			# console.log("Right Border Meridian")
			if @y < (borderTop + 20) || @y > borderBottom - 20
				# console.log("LEFT")
				@moveLeft()
			else if @y < centerY && @y > borderTop
				# console.log("UP")
				@moveUp()
			else if @y > centerY && @y < borderBottom
				# console.log("DOWN")
				@moveDown()
			else
				randDir = [1, 2]
				randDir = randDir[Math.floor(Math.random() * randDir.length)]
				switch randDir
					when 1 then @moveUp()
					when 2 then @moveDown()

		else if @y <= borderTop
			# console.log("North Pole")
			if @x < (borderLeft + 20) || @x > borderRight - 20
				# console.log("DOWN")
				@moveDown()
			else if @x > centerX and @x < borderRight
				# console.log("RIGHT")
				@moveRight()
			else if @x < centerX and @x > borderLeft
				# console.log("LEFT")
				@moveLeft()
			else
				randDir = [1, 2]
				randDir = randDir[Math.floor(Math.random() * randDir.length)]
				switch randDir
					when 1 then @moveRight()
					when 2 then @moveLeft()
		else if @y >= borderBottom
			# console.log("South Pole")
			if @x < (borderLeft + 20) || @x > borderRight - 20
				# console.log("UP")
				@moveUp()
			else if @x > centerX && @x < borderRight
				# console.log("RIGHT")
				@moveRight()
			else if @x < centerX && @x > borderLeft
				# console.log("LEFT")
				@moveLeft()
			else
				randDir = [1, 2]
				randDir = randDir[Math.floor(Math.random() * randDir.length)]
				switch randDir
					when 1 then @moveRight()
					when 2 then @moveLeft()
		else
			# console.log("Default")
			if roundNumber%2==0
				if @x > centerX
					# console.log("LEFT")
					@moveLeft()
				else
					# console.log("RIGHT")
					@moveRight()
			else
				if @y > centerY
					# console.log("UP")
					@moveUp()
				else
					# console.log("DOWN")
					@moveDown()
		return null

	towardsCenter: () =>
		borderLeft = @sightRadius
		borderRight = canvas.width - @sightRadius
		borderTop = @sightRadius
		borderBottom = canvas.height - @sightRadius

		centerX = (borderLeft + borderRight)/2
		centerY = (borderTop + borderBottom)/2

		fromCenterX = Math.abs(centerX - @x)
		fromCenterY = Math.abs(centerY - @y)

		if fromCenterX > fromCenterX
			if centerX - @x > 0
				# console.log("RIGHT")
				@moveRight()
			else
				# console.log("LEFT")
				@moveLeft()
		else
			if centerY - @y > 0
				# console.log("DOWN")
				@moveDown()
			else
				# console.log("UP")
				@moveUp()

		return null
