extends State

@export var walk_state: State
@export var idle_state: State
@export var cast_state: State
@export var roll_speed: float
@export var roll_duration : float
var roll_timer : float
var roll_direction : Vector2

func enter() -> void:
	roll_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	roll_timer = roll_duration
	
func process_physics(delta: float) -> State:
	parent.velocity = (roll_direction * roll_speed)
	parent.move_and_slide()
	
	roll_timer -= delta
	if roll_timer <= 0:
		return walk_state
	return null
