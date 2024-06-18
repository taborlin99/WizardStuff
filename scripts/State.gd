extends Node
class_name State

signal state_transitioned

func enter():
	pass
	
func exit():
	pass
	
func physics_update(_delta) -> State:
	return null

func input(_event) -> State:
	return null
