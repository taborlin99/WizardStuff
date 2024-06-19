extends Node
class_name State

var parent : CharacterBody2D
@onready var player = get_node("/root/Main/PixelPerfectRendering/SubViewport/Game/player")


signal state_transitioned

func enter():
	pass
	
func exit():
	pass
	
func physics_update(_delta) -> State:
	return null

func input(_event) -> State:
	return null
