extends PanelContainer

signal slot_clicked(index: int, button: int)

@onready var color_rect = $MarginContainer/ColorRect
@onready var texture_rect = $MarginContainer/TextureRect

func _ready():
	pass

func _process(delta):
	pass

func set_item_data(item_data: ItemData):
	if item_data.empty == true:
		color_rect.show()
	else:
		color_rect.hide()
	if item_data.texture:
		texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]


func _on_gui_input(event):
	if event is InputEventMouseButton \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
