extends State

@export var idle_state : State
@export var shoot_state : State
@export var walk_state : State
var direction : Vector2
@onready var player = get_node(Constants.playerPath)
@onready var target_position = player.global_position



func _ready():
	print(player.global_position)
	pass
	#direction = (player.global_position - parent.global_position)
	#print("this is the direction", direction)
	#print("player",player.global_position)
	#print(parent.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	print(player.global_position)
	
