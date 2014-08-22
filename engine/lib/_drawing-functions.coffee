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

drawText = (x, y, txt) ->
	context.fillText(txt, x, y)

drawCircle = (x, y, radius, color = '#000000', fill = false, lineWidth = 1) ->
	context.beginPath()
	context.arc(x, y, radius, (Math.PI/180)*0, (Math.PI/180)*360, true)
	if fill
		context.fillStyle = color
		context.fill()
	else
		context.lineWidth = lineWidth
		context.strokeStyle = color
		context.stroke()
		context.lineWidth = 1
	context.closePath()
