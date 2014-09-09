class GameController extends GameObject

	score = null

	constructor: (name) ->
		@collisionGroup = 'controller'
		super name

	awake: () =>
		@reset()
		super

	update: (dt) =>
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
		gameObjects = [this, new Player('')]

		###
		p2 = new Player("P2")
		p2.keyUp = KeyCode.Up
		p2.keyLeft = KeyCode.Left
		p2.keyRight = KeyCode.Right
		p2.keyDown = KeyCode.Down
		p2.color = "#0000ff"
		###

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
