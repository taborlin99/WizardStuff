extends Entity

@export var player: Node2D
@onready var nav_agent = $NavigationAgent2D
@onready var nav_to_player : Vector2
@onready var direction_to_player : Vector2 = Vector2.ZERO
@export var animation_tree : Node
@export var animation_player : Node
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var nav_direction : Vector2
var path_cooldown : float
@onready var cooldown : float

func _ready():
	animation_state.travel("move")
	reset_cooldown()
	reset_path_cooldown()

func _physics_process(delta: float):
	direction_to_player = player.global_position - global_position
	random_attack_timer(delta)
	pathfind_timer(delta)
	nav_direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = velocity.move_toward(nav_direction * max_speed, acceleration)
	animation_tree.set("parameters/shoot/blend_position", direction_to_player)
	move_and_slide()	

func pathfind():
	nav_agent.target_position = player.global_position
	print("path making")

func spell_hit(damage):
	modify_health(-damage)
	print(self.name," health: ",current_health)

func reset_cooldown():
	cooldown = randf_range(3,7)

func reset_path_cooldown():
	path_cooldown = 1
	print("reset path cooldown")
	
func pathfind_timer(delta):
	path_cooldown -= delta
	if path_cooldown <= 0:
		print("looking")
		pathfind()
		reset_path_cooldown()

func random_attack_timer(delta):
	cooldown -= delta
	if cooldown <= 0:
		shoot()
		print(cooldown)
		reset_cooldown()

func shoot():
	animation_state.travel("shoot")
	#animation_tree.set("parameters/shoot/blend_position", direction_to_player)
	spawn_proj()

func spawn_proj():
	print("just imagine")
	pass
