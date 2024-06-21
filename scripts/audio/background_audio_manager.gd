extends Node

#@onready var test = $test
@onready var bg_music = $bg_music

var playerStateMachine: Node

var background_node

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_music.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_state_change(new_state):	
	match new_state.name:
		"Walk":
			$player_sounds.play()
		"Idle":
			$player_sounds.stop()
		"Roll":
			$player_sounds.get_node("roll").play()
	#if(new_state == "walking"):
		#$player_sounds.play()
	#else:
		#$player_sounds.stop()
	pass

#func _play_sfx(_sfx):
	#test.play()
	#pass

func add_player_state_machine(_playerStateMachine):
	playerStateMachine = _playerStateMachine
	playerStateMachine.player_state_signal.connect(_on_state_change)
