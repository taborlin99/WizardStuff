extends State

@export var idle_state : State
@export var shoot_state : State
@export var walk_state : State
var target_direction : Vector2
var dash_speed = 100
var attack_finished : bool
var time_elapsed : float = 0
var slowdown_speed : float = 50

func enter():
	parent.animation.play("shoot_right")
	attack_finished = false

func physics_update(delta):
	time_elapsed += delta
	if attack_finished == true:
		return walk_state
	if time_elapsed < 0.4:
		windup(delta)
		target_direction = Vector2(player.global_position - parent.global_position)
		#print("winding")
	if time_elapsed >= 0.4 and time_elapsed < 0.7:
		target_direction = target_direction.normalized()
		attack(target_direction, delta)
		#print("attacking")
	else:
		parent.velocity = parent.velocity.move_toward(Vector2.ZERO, slowdown_speed * delta)
		#print("hittin the brakes")
	parent.move_and_slide()

func windup(delta):
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, slowdown_speed * delta)
	

func attack(direction, delta):
	parent.velocity = target_direction * dash_speed
	print(parent.velocity)
	var dir = Static.animation_direction(direction)
	var anim = "shoot" + dir
	parent.animation.play(anim)

func _on_animation_player_animation_finished(anim_name):
	attack_finished = true
	time_elapsed = 0

