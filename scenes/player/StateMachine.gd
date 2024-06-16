extends State

@export var starting_state : State
var current_state : State

func init(new_parent: CharacterBody2D) -> void:
	for child in get_children():
		child.parent = new_parent
	change_state(starting_state)
	
#change to new state, and call exit logic of old state, and enter logic of new state
func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	print(current_state)
	
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
	
	
