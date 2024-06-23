@tool
extends Node

@export var slots = 3

var spell_components = []
var spell_index = 0

func _ready():
	for n in slots:
		spell_components.append(null)
	add_component("bolt", 0)

func add_component(component_name, index):
	if index < slots:
		var component = load("res://scenes/spells/" + component_name + "/" + component_name + ".tscn")
		spell_components[index] = component
		
func cast(data):
	# cast component at index, then wait for it to finish
	if spell_index < spell_components.size() and spell_components[spell_index]:
		instantiate_component(spell_components[spell_index], data)
		spell_index += 1
	else:
		spell_index = 0

func instantiate_component(component, data):
	var instance = component.instantiate()
	instance.data = data
	instance.spell_end.connect(cast)
	get_node("/root").add_child(instance)
	
	

# keeping here in case we go back to grids

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
	pass
	#config_path = config_path % self.get_name()
	#var config_file : ConfigFile = ConfigFile.new()
	#if FileAccess.file_exists(config_path):
		#var err = config_file.load(config_path)
		#if err != OK:
			#print("Error loading wand config file: " + config_path)
			#return
		#wand_grid = config_file.get_value("Grid", "grid_available_slots")
	#else:
		#print("Wand configuration file missing")
	
