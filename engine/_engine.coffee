
#
# Raw functions/utility classes and definitions
#
# @codekit-prepend "_debug.coffee";

# @codekit-prepend "lib/_drawing-functions.coffee";
# @codekit-prepend "lib/_game-loop-bootstrap.coffee";
# @codekit-prepend "lib/_KeyCode.coffee";
# @codekit-prepend "lib/_game-object.coffee";


# @codekit-prepend "_input-handling.coffee";



canvas = null
context = null
gameStarted = false
gameObjects = []

$ () ->
	canvas = document.getElementsByTagName('canvas')[0]
	context = canvas.getContext('2d');

	beginGameLoop()
