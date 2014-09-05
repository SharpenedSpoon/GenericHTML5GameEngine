class IanRobot extends Robot

	takeTurn: (roundNumber) =>
		if roundNumber % 3
			@lookAround()
		else
			if @objectsSighted.length > 0
				if @objectsSighted[0].collisionGroup == 'flag'
					# capture or go towards the flag!
					if @objectsSighted[0].x == @x && @objectsSighted[0].y == @y
						@attack()
					else
						@moveTowards(@objectsSighted[0].x, @objectsSighted[0].y)
				else
					# run away!
					@moveAway(@objectsSighted[0].x, @objectsSighted[0].y)
			else
				# if we don't see anything....
				@moveRandomly();

	moveRandomly: () =>
		r = Math.floor(Math.random() * 4)
		switch r
			when 0 then @moveUp()
			when 1 then @moveRight()
			when 2 then @moveDown()
			when 3 then @moveLeft()

	moveTowards: (targetX, targetY) =>
		dx = targetX - @x
		dy = targetX - @y

		# reverse the logic from moveAway to move towards!
		dx *= -1
		dy *= -1
		if Math.abs(dx) > Math.abs(dy)
			if dx < 0
				@moveRight()
			else if dx > 0
				@moveLeft()
		else
			if dy < 0
				@moveDown()
			else if dy > 0
				@moveUp()

	moveAway: (targetX, targetY) =>
		dx = targetX - @x
		dy = targetX - @y

		if Math.abs(dx) > Math.abs(dy)
			if dx < 0
				@moveRight()
			else if dx > 0
				@moveLeft()
		else
			if dy < 0
				@moveDown()
			else if dy > 0
				@moveUp()
