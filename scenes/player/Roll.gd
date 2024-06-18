extends State

@export var parent : CharacterBody2D
@export var animation : AnimationPlayer
@export var walk_state : State
@export var idle_state : State
@export var cast_state : State

@export var roll_speed : float = 100
var velocity : Vector2
var direction : Vector2
var roll_complete : bool

func enter():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	animate()
	print("roll entered")
	roll_complete = false
	
func input(_event) -> State:
	return null

func physics_update(_delta) -> State:
	direction = direction.normalized()
	parent.velocity = direction * roll_speed
	parent.move_and_slide()
	if roll_complete == true:
		return walk_state
	return null
	
func animate():
	var dir = Static.animation_direction(direction)
	if dir:
		var anim = "roll" + dir
		animation.play(anim)
	else:
		pass

func exit():
	pass


func _on_animation_player_animation_finished(animation_name):
	roll_complete = true
	print("animation finished")
