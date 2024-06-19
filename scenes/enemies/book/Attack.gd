extends State

@export var idle_state : State
@export var shoot_state : State
@export var walk_state : State
var target_direction : Vector2
var dash_speed = 120
var attack_finished : bool

func enter():
	parent.animation.play("shoot_right")
	target_direction  = Vector2(player.global_position - parent.global_position)
	parent.velocity = Vector2.ZERO
	attack_finished = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	attack(target_direction, delta)
	if attack_finished == true:
		return walk_state
	
	
func attack(direction, delta):
	parent.velocity = target_direction * dash_speed * delta
	parent.move_and_slide()
	
	var dir = Static.animation_direction(direction)
	var anim = "shoot" + dir
	parent.animation.play(anim)
	
func _on_animation_player_animation_finished(anim_name):
	attack_finished = true
