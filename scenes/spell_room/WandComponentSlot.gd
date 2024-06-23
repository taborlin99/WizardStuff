extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _drop_data(at_position, data):
	texture = data["origin_texture"]

func _can_drop_data(at_position, data):
	return true
