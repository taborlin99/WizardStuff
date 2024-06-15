extends EditorInspectorPlugin

func _can_handle(object):
	var script = object.get_script()
	if script != null:
		if script.resource_path == "res://addons/wandgrid/WandProperties.gd":
			return true
	return false

func _parse_begin(object):
	if object.columns > 0:
		if object.rows > 0:
				var grid = preload("res://addons/wandgrid/Editor/editor_wand_grid.tscn")
				grid = grid.instantiate()
				grid.init(object.rows,object.columns,object.get_name())
				add_custom_control(grid)
