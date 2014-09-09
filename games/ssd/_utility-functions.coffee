gravity = 1

checkCollision = (originalGameObject, x1, y1, wid, hei) ->
	output = false
	for go in gameObjects
		if go.enabled && go != originalGameObject
			if go.x >= x1 && go.x <= x1 + wid && go.y >= y1 && go.y <= y1 + hei
				output = go
				break
	return output

checkCollisionWithGroup = (group, x1, y1, wid, hei) ->
	output = false
	for go in gameObjects
		if go.enabled && go.collisionGroup == group
			if go.x >= x1 && go.x <= x1 + wid && go.y >= y1 && go.y <= y1 + hei
				output = go
				break
	return output
