extends Node

var current_state : State
@export var initial_state : State
@export var parent : Node

signal player_state_signal(new_state)

func _ready():
	BackgroundAudioManager.add_player_state_machine(self)
	for child in get_children():
		child.parent = parent
		print(child)

	change_state(initial_state)
	
func change_state(new_state : State):
	player_state_signal.emit(new_state)
	if current_state:
		current_state.exit()
	
	current_state = new_state
	print(current_state)
	current_state.enter()
	
func input(event):
	var new_state = current_state.input(event)
	
	if new_state:
		change_state(new_state)  

func physics_update(delta):
	var new_state = current_state.physics_update(delta)
	if new_state:
		change_state(new_state)
