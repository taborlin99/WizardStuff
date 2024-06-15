extends State

@export var walk_state: State
@export var roll_state: State
@export var cast_state: State

func enter() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("roll"):
		return roll_state
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		return walk_state
	#if Input.is_action_just_pressed("click"):
		#return cast_state
	return null
