extends State

@export var parent : CharacterBody2D
@export var animation : AnimationPlayer
@export var idle_state : State
@export var roll_state : State
@export var cast_state : State

@export var max_speed : float
@export var acceleration : float
var velocity : Vector2
var direction : Vector2

func enter():
	#animation.play("walk")
	pass
	
func input(_event) -> State:
	#if Input.is_action_just_pressed("click"):
		#return cast_state
		
	if Input.is_action_just_pressed("roll"):
		print("roll requested")
		return roll_state

	if Input.get_vector("move_left", "move_right", "move_up", "move_down") == Vector2.ZERO:
		return idle_state
	return null

func physics_update(_delta) -> State:
	animate()
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	parent.velocity = direction * max_speed
	parent.move_and_slide()
	return null
	
func animate():
	var dir = Static.animation_direction(direction)
	if dir:
		var anim = "walk" + dir
		animation.play(anim)

func exit():
	pass
