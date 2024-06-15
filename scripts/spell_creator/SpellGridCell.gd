extends TextureRect

var open_texture = preload("res://Assets/Editor/spell_square_open.webp")
var closed_texture = preload("res://Assets/Editor/spell_square_closed.webp")

func set_state(flag: bool):
	if flag:
		set_texture(open_texture)
	else:
		set_texture(closed_texture)
