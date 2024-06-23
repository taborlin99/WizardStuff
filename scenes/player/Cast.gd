extends State

#	right now kinda janky, player will enter this state and repeatedly call
#	cast_spell_chain for as long as mouse is held.
#	
#	I need to add a cooldown, either to the cast, or to the state itself
#	Also only works when running the "game.tscn" rather than main.

@export var animation : AnimationPlayer
@export var walk_state : State
@export var roll_state : State
@export var idle_state : State
@export var cast_movespeed : float
var direction : Vector2

func enter():
	print("entered casting")
	pass
	
func input(event):
	#direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#direction = direction.normalized()
	#parent.velocity = direction * cast_movespeed
	#parent.move_and_slide()
	return null
	
func physics_update(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	parent.velocity = direction * cast_movespeed
	parent.move_and_slide()
	animate()
	if Input.is_action_pressed("click") == false:
		return walk_state
	cast_spell_chain
		
func animate():
	pass
	var direction = parent.get_global_mouse_position() - parent.global_position
	var dir = Static.animation_direction(direction)
	if dir:
		var anim = "walk" + dir
		animation.play(anim)

func cooldown():
	#need to add
	pass

func cast_spell_chain():
	var cast_direction = parent.get_global_mouse_position() - parent.global_position
	print("casting in this direction: ",cast_direction)
	#use this to initiate wand spell chain

func exit():
	pass
