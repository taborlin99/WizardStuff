extends Entity

@export var player: Node2D
@onready var nav_agent = $NavigationAgent2D
@onready var direction : Vector2 = Vector2.ZERO

func _physics_process(_delta: float):
	direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = velocity.move_toward(direction * max_speed, acceleration)
	move_and_slide()	

func pathfind():
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	pathfind()

func spell_hit(damage):
	modify_health(-damage)
	print(self.name," health: ",current_health)
