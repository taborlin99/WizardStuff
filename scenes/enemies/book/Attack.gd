extends State

@export var idle_state : State
@export var shoot_state : State
@export var walk_state : State
var target_direction : Vector2
var dash_speed = 200
#@onready var player = get_node(Constants.playerPath)
#@onready var target_position = player.global_position



func _ready():
	#print("attack",type_string(typeof(player)))
	#print(player.global_position)
	#print(parent.global_position)
	#target_direction  = Vector2(player.global_position - parent.gloabl_position)
	#print(target_direction)
	#direction = (player.global_position - parent.global_position)
	#print("this is the direction", direction)
	#print("player",player.global_position)
	#print(parent.global_position)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	print(player.global_position)
	
func attack(direction):
	parent.velocity = direction * dash_speed
