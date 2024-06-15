extends State

@export var starting_state : State
var current_state : State

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	change_state(starting_state)
	
#change to new state, and call exit logic of old state, and enter logic of new state
func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	
func process_physics(float):
	var new_state = current_state.process_physics(float)
	if new_state:
		change_state(new_state)
		
func process_input(InputEvent):
	var new_state = current_state.process_input(InputEvent)
	if new_state:
		change_state(new_state)
		
func process_frame(float):
	var new_state = current_state.process_frame(float)
	if new_state:
		change_state(new_state)
	
	
