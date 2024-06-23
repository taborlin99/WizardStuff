extends Entity
class_name Player

@export var animations : Node
@export var state_machine : Node

func _ready():
	pass
	
func _physics_process(delta):
	state_machine.physics_update(delta)
	
func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_G:
		var data = {}
		data["position"] = position
		data["velocity"] = velocity
		WandList.wand("DefaultWand").cast(data)
		print("hello world")
	else:
		state_machine.input(event)
