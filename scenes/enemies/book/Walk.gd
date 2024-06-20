extends State

@export var max_speed : float
@export var acceleration : float
var direction_to_player : Vector2
@export var nav_agent : NavigationAgent2D
@export var attack_state : State
@export var idle_state : State
@export var shoot_state : State
@export var attack_range : float = 50

var time_elapsed : float = 0

func enter():
	nav_agent.target_position = player.global_position
	parent.animation.play("move")
	time_elapsed = 0

func physics_update(delta):
	var distance_to_player = parent.global_position.distance_to(player.global_position)
	if distance_to_player < attack_range and time_elapsed > 2:
		return attack_state
		
	#if nav_agent.is_navigation_finished() and time_elapsed > 2:
		#return attack_state
	#if player.global_position - parent.global_position < Vector
	#if attack_range.area_entered(player) and time_elapsed > 2:
		#return attack_state
	#var bodies = player.get_child(collision).get_overlapping_bodies()
	#print(bodies)
	timer(delta)
	nav_agent.target_position = player.global_position
	var nav_direction = nav_agent.get_next_path_position()
	direction_to_player = Vector2(nav_direction - parent.global_position)
	direction_to_player = direction_to_player.normalized()
	parent.velocity = parent.velocity.move_toward(Vector2(direction_to_player * max_speed), acceleration * delta)
	parent.move_and_slide()
	
func timer(delta):
	time_elapsed += delta
