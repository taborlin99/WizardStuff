extends Node

@onready var test = $test
@onready var bg_music = $bg_music


var background_node

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_music.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_state_change(new_state):
	pass

func _play_sfx(sfx):
	test.play()
	pass
