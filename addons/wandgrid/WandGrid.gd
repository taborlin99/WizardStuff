@tool
extends EditorPlugin

var plugin = preload("res://addons/wandgrid/WandGridInspectorPlugin.gd")

func _enter_tree():
	plugin = plugin.new()
	add_inspector_plugin(plugin)
	
	add_custom_type("WandProperties","Node",
	preload("res://addons/wandgrid/WandProperties.gd"),
	preload("res://Assets/Editor/wand_editor_icon.svg"))

func _exit_tree():
	remove_inspector_plugin(plugin)
