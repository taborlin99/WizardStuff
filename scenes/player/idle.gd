extends State

@export var animation : AnimationPlayer
@export var walk_state : State
@export var roll_state : State
@export var cast_state : State

func enter():
	animation.play("idle")
	
func input(_event):
	if Input.is_action_pressed("click"):
		return cast_state
		print("idle to cast")
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		return walk_state
	return null
	#if Input.is_action_just_pressed("click"):
		#return cast_state
#
	#if Input.is_action_just_pressed("roll") and :
		#return roll_state

func physics_update(_delta):
	pass

func exit():
	pass
