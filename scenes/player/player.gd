extends Entity
class_name Player

@export var animations : Node
@export var state_machine : Node

func _ready():
	pass
	
func _physics_process(delta):
	state_machine.physics_update(delta)
	
func _unhandled_input(event):
	state_machine.input(event)

