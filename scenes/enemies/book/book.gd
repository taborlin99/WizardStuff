extends Entity
class_name Book

@export var animation : Node
@export var state_machine : Node
@export var nav_agent : Node


func _ready():
	pass

func _physics_process(delta):
	state_machine.physics_update(delta)


