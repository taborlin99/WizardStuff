extends TextureRect

func _ready():
	pass # Replace with function body.

func _get_drag_data(at_position):
	
	var data = {}
	data["origin_texture"] = texture
	
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = texture
	drag_texture.size = Vector2(64,64)
	
	# trick to make preview aligned with center of mouse
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.position = -0.5 * drag_texture.size
	set_drag_preview(control)
	
	return data
	
func _can_drop_data(at_position, data):
	return false
	
func _drop_data(at_position, data):
	pass
