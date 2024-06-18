extends Entity
class_name Book

@export var animations : Node
@export var state_machine : Node
@export var nav_agent : Node

var player = Constants.playerPath


func _ready():
	print(player)

func _physics_process(delta):
	state_machine.physics_update(delta)


