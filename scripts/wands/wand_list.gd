extends Node


func wand(name):
	var wand = get_node(name)
	wand.load_properties()
	return wand
