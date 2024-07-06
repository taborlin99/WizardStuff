extends PanelContainer

signal slot_clicked(index: int, button: int)
@onready var margin_container = $MarginContainer
@onready var color_rect = $MarginContainer/ColorRect
@onready var texture_rect = $MarginContainer/TextureRect

func set_slot_data(item_data: ItemData) -> void:
	if item_data.texture:
		texture_rect.texture = item_data.texture
	if item_data.locked == true:
		self_modulate.a = 0
	if item_data.empty == true:
		color_rect.show()
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
