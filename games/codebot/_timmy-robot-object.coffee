class TimmyRobot extends Robot

	takeTurn: (roundNumber) =>
		r = Math.floor(Math.random() * 6)
		switch r
			when 0 then @moveUp()
			when 1 then @moveRight()
			when 2 then @moveDown()
			when 3 then @moveLeft()
			when 4 then @lookAround()
			when 5 then @attack()
		return null
