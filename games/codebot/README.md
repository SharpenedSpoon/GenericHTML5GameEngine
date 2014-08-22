# Codebot robots API

## Description
A robot is a class that extends the class "Robot" - see _dummy-robot-object.coffee for an example. This class only needs one function, `takeTurn` which takes the argument `roundNumber` - which is, of course, the current round number. Inside of takeTurn, only one "action" is allowed, and in general no class variables may be created, modified, or destroyed. Although javascript doesn't allow it, just assume that you only have 'getter' access to all class variables.

## Variables, Methods, and States

### Robot class instance variables
The following variables are available for you to access and get information (but _not_ overwrite with new values). Recall that in coffeescript, you may use the "@" symbol as a shortcut for "this.", which is convenient, and used here, for accessing instance variables and methods.

Variable | Description
-------- | -----------
`@x` | Your robot's (top left) x-coordinate
`@y` | Your robot's (top left) y-coordinate. Note that the y-axis points down
`@width` | Your robot's width
`@height` | Your robot's height
`@center` | An object containing the x- and y- coordinates of your robot's center (access with `@center.x` and `@center.y`)
`@sightRadius` | How far you can see when you `@lookAround`
`@collisionGroup` | Your robot's collision group, which is "robot" - the only other collision group currently is "flag" for the flag.
`@speed` | The distance your robot moves when calling one of the move actions
`@objectsSighted` | An array of object states from the last call of `@lookAround`. Each call of `@lookAround` will clear this array and repopulate it as is appropriate.


### Robot actions
These are the methods (we will call them actions) which you are allowed to call during the `takeTurn` method. Note that only *one* of these methods may be called during each turn!

Action | Description
-------- | -----------
`@moveUp` | Moves up
`@moveRight` | Moves right
`@moveDown` |  Moves down
`@moveLeft` | Moves left
`@lookAround()` | Looks around within a `@sightRadius` circle and populates the `@objectsSighted` array with the current state of any and all GameObjects around you
`@attack()` | Attacks and destroys any GameObject that you are immediately on top of.


### GameObject states
When you perform a `@lookAround()` the `@objectsSighted` array is populated with the current state of all GameObjects around you. Specifically, the `@objectsSighted` array is filled with these objects:

	{
		name
		x
		y
		center
		width
		height
		collisionGroup
		color
	}

So, if you know that there is at least one GameObject spotted, you may determine what type of object it is by calling `@objectsSighted[0].collisionGroup` (which is a string, either "flag" or "robot"). To determine its x-coordinate, call `@objectsSighted[0].x` ... have fun!


### Robot class methods
There are a few (technically just one right now) methods that are provided inside the robot class to help with common calculations.

Method | Description
-------- | -----------
`@distance(x1, y1, x2, y2)` | Returns the Euclidean distance between two points. (for non-mathy people, note that the order of the coordinates does not matter)


### Global variables
There are two global variables that you may access.

Variable | Description
-------- | -----------
`canvas.width` | The total width of the battle arena
`canvas.height` | The total height of the battle arena
