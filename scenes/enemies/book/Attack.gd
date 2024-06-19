extends State

@export var idle_state : State
@export var shoot_state : State
@export var walk_state : State
var target_direction : Vector2
var dash_speed = 200
var attack_finished : bool
var time_elapsed : float = 0
var slowdown_speed : float = 100

func enter():
	parent.animation.play("shoot_right")
	target_direction  = Vector2(player.global_position - parent.global_position)
	attack_finished = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if attack_finished == true:
		return walk_state
	find_time_elapsed(delta)
	if time_elapsed < 0.4:
		windup(delta)
		print("winding up")
	else:
		attack(target_direction, delta)
		print("attacking")
	
func windup(delta):
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, slowdown_speed * delta)
	print(parent.velocity)
	parent.move_and_slide()

func attack(direction, delta):
	parent.velocity = target_direction * dash_speed * delta
	parent.move_and_slide()
	var dir = Static.animation_direction(direction)
	var anim = "shoot" + dir
	parent.animation.play(anim)

	
func _on_animation_player_animation_finished(anim_name):
	attack_finished = true
	time_elapsed = 0

func find_time_elapsed(delta):
	time_elapsed += delta

	
