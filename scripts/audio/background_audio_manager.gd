extends Node

@onready var test = $test

var background_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_state_change(new_state):
	pass

func _play_sfx(sfx):
	test.play()
	pass
