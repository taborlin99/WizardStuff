@tool
extends Node

@export var columns = 0
@export var rows = 0
var wand_grid : Array = create_new_grid()

var config_path = "res://Configuration/Wands/%s.cfg"

func create_new_grid():
	var new_grid = []
	for x in range(columns):
		new_grid.append([])
		for y in range(rows):
			new_grid[x].append(false)
	return new_grid
	
func load_properties():
	config_path = config_path % self.get_name()
	var config_file : ConfigFile = ConfigFile.new()
	if FileAccess.file_exists(config_path):
		var err = config_file.load(config_path)
		if err != OK:
			print("Error loading wand config file: " + config_path)
			return
		wand_grid = config_file.get_value("Grid", "grid_available_slots")
	else:
		print("Wand configuration file missing")
	
