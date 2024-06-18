extends Node
class_name Static

static func cardinal_four(input) -> Vector2: # snapps vector2 value to 4 cardinal directions
	input = input.normalized()
	input.y = input.y + 0.1
	input.x = snapped(input.x, 1)
	input.y = snapped(input.y, 1)
	var output = input
	if output.x:
		output.y = 0
	return output

#static func cardinal_eight(dir) -> Vector2: # snapps vector2 value to 8 cardinal directions
	#dir = dir.normalized
	#dir.x = snapped(dir.x, 1)
	#dir.y = snapped(dir.y, 1)
	#return dir
	
static func animation_direction(direction):	#gets an animation string, and appends "_direction"
	var dir = cardinal_four(direction)
	if dir == Vector2.RIGHT:
		return ("_right")
	if dir == Vector2.LEFT:
		return("_left")
	if dir == Vector2.UP:
		return("_up")
	if dir == Vector2.DOWN:
		return("_down")
	return null
