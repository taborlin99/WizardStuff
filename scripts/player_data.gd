extends Node2D

@export var currentWand : String  = ""

func get_equipped_wand():
	return WandList.wand(currentWand)
