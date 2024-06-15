@tool
extends GridContainer

var button = preload("res://addons/wandgrid/Editor/editor_wand_grid_button.tscn")
signal update_grid(state, index)

var config_path = "res://Configuration/Wands/%s.cfg"
var config_file : ConfigFile = ConfigFile.new()

func init(cell_rows, cell_columns, wand_name):
	# load config file if it exists, otherwise create a new one
	# then initialize the grid widget
	columns = cell_columns
	config_path = config_path % wand_name
	if FileAccess.file_exists(config_path):
		var err = config_file.load(config_path)
		if err != OK:
			print("Error loading config file: " + config_path)
			return
		var dimensions = config_file.get_value("Grid", "grid_dimensions")
		if dimensions[0] != cell_rows || dimensions[1] != cell_columns:
			config_file.set_value("Grid", "grid_dimensions", [cell_rows,cell_columns])
			config_file.set_value("Grid", "grid_available_slots", new_grid_array(cell_rows, cell_columns))
			
	else:
		config_file.set_value("Grid", "grid_dimensions", [cell_rows,cell_columns])
		config_file.set_value("Grid", "grid_available_slots", new_grid_array(cell_rows, cell_columns))
		
	for x in range(cell_rows):
		for y in range(cell_columns):
			var new_button = button.instantiate()
			add_child(new_button)
			new_button.index = [x, y]
			new_button.triggered.connect(_on_button_trigger)
			if config_file.get_value("Grid", "grid_available_slots")[x][y] == true:
				new_button.set_pressed_no_signal(true)
			
func _on_button_trigger(state, index):
	var grid = config_file.get_value("Grid", "grid_available_slots")
	grid[index[0]][index[1]] = state
	config_file.set_value("Grid", "grid_available_slots", grid)
	config_file.save(config_path)
	
func new_grid_array(rows, columns):
	var slots = []
	for x in range(rows):
		slots.append([])
		for y in range(columns):
			slots[x].append(false)
	return slots
	
