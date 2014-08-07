now = 0
dt = 0
dtStep = 0
last = 0
step = 1/60
frames = 0

timestamp = () -> window.performance.now()


frame = () ->
	frames = 0
	now = timestamp();
	dt = dt + Math.min(1, (now - last) / 1000)
	dtStep = dt
	while (dtStep > step)
		dtStep = dtStep - step
		frames++
		fixedUpdate(step)
	update(dt)
	render(dtStep)
	last = now
	requestAnimationFrame(frame)
	return null


beginGameLoop = () ->
	createGameObjects()

	awake()
	start()

	last = timestamp()

	requestAnimationFrame(frame)

	return true
