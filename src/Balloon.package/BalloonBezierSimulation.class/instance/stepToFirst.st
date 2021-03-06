private
stepToFirst
	|  startX endX startY endY deltaY fwX1 fwX2 fwY1 fwY2 
	steps scaledStepSize squaredStepSize |
	(end y) >= (start y) ifTrue:[
		startX := start x.	endX := end x.
		startY := start y.	endY := end y.
	] ifFalse:[
		startX := end x.	endX := start x.
		startY := end y.	endY := start y.
	].

	deltaY := endY - startY.

	"Quickly check if the line is visible at all"
	(deltaY = 0) ifTrue:[^self].

	fwX1 := (startX + endX - (2 * via x)) asFloat.
	fwX2 := (via x - startX * 2) asFloat.
	fwY1 := (startY + endY - (2 * via y)) asFloat.
	fwY2 := ((via y - startY) * 2) asFloat.
	steps := deltaY asInteger * 2.
	scaledStepSize := 1.0 / steps asFloat.
	squaredStepSize := scaledStepSize * scaledStepSize.
	fwDx := fwX2 * scaledStepSize.
	fwDDx := 2.0 * fwX1 * squaredStepSize.
	fwDy := fwY2 * scaledStepSize.
	fwDDy := 2.0 * fwY1 * squaredStepSize.
	fwDx := fwDx + (fwDDx * 0.5).
	fwDy := fwDy + (fwDDy * 0.5).

	lastX := startX asFloat.
	lastY := startY asFloat.
