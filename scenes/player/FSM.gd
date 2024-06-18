extends Node

var current_state : State
@export var initial_state : State
@export var parent : Node

func _ready():
	for child in get_children():
		child.parent = parent

	change_state(initial_state)
	
func change_state(new_state : State):
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	#print("changed state to ",current_state)
	
func input(event):
	var new_state = current_state.input(event)
	
	if new_state:
		change_state(new_state)  

func physics_update(delta):
	var new_state = current_state.physics_update(delta)
	if new_state:
		change_state(new_state)