extends Node
class_name State

@export var animation_name: String
@export var parent: Node2D

func enter():
	#parent.animations.play(anmation_name)
	pass
	
func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func process_input(_event: InputEvent) -> State:
	return null
