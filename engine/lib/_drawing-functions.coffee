drawSquare = (x, y, w, h, color = '#000000') ->
	context.fillStyle = color
	context.fillRect(x, y, w, h)
	return null

drawLine = (x1, y1, x2, y2, color = '#000000') ->
	context.beginPath()
	context.moveTo(x1, y1)
	context.lineTo(x2, y2)
	context.strokeStyle = color
	context.stroke()
	return null

drawPolygon = (vertexArray, color = '#000000') ->
	context.beginPath()
	firstVertex = vertexArray[0]
	context.moveTo(firstVertex[0], firstVertex[1])
	for vertex in vertexArray
		context.lineTo(vertex[0], vertex[1])
	context.lineTo(firstVertex[0], firstVertex[1])
	context.strokeStyle = color
	context.stroke()

drawText = (txt, x, y) ->
	context.fillText(txt, x, y)
