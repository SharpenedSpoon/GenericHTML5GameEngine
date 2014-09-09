class GameController extends GameObject

	score = null

	constructor: (name) ->
		@collisionGroup = 'controller'
		super name

	awake: () =>
		super

	start: () =>
		super

	update: (dt) =>
		if numberOfBricks == 0
			console.log 'No bricks - resetting'
			@reset()
		super dt

	render: (dt) =>
		context.fillStyle = '#000'
		context.font = '100 16px sans-serif'
		drawText(15, 15, 'Score: ' + @score)
		super dt

	addScore: (n) =>
		@score += n

	reset: () =>
		@score = 0
		gameObjects = [this]

		p1 = new Player("P1")
		p1.keyUp = KeyCode.W
		p1.keyLeft = KeyCode.A
		p1.keyRight = KeyCode.D
		p1.keyDown = KeyCode.S
		p1.color = "#badcab"
		p1.awake()

		console.log p1

		bWid = 32
		bHei = 16

		for xx in [0..Math.floor((canvas.width - bWid) / bWid)]
			for yy in [1..5]
				brick = new Brick('Brick ' + xx + '-' + yy)
				brick.width = bWid
				brick.height = bHei
				brick.x = xx * brick.width + 5 # the 5 is a magic number, for padding
				brick.y = yy * brick.height

		ball = new Ball("ball")
