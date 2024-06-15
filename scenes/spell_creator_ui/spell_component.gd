extends TextureRect

var selected = false
@onready var home_position = global_position

func _ready():
	pass # Replace with function body.

func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			global_position = home_position
