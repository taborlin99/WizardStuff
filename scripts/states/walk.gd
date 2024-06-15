extends State

@export var idle_state: State
@export var roll_state: State
@export var cast_state: State
@export var animation_tree : Node
@export var animation_player : Node

func enter():
	pass

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("roll"):
		return roll_state
	#if Input.is_action_just_pressed("click"):
		#return cast_state
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") == Vector2.ZERO:
		return idle_state
	return null
	
func process_physics(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	parent.velocity = parent.velocity.move_toward(parent.max_speed * direction, parent.acceleration)
	parent.move_and_slide()
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/walk/blend_position", direction)
	else: animation_tree.set("parameters/walk/blend_position", Vector2.DOWN)
	
