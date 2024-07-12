extends PanelContainer

const Slot = preload("res://inventory/interface/slot/slot.tscn")
@onready var item_grid = $MarginContainer/ItemGrid
@onready var inventory_data = preload("res://inventory/interface/pouch/pouch.tres")

func _ready():
	populate_item_grid(inventory_data)
	inventory_data.inventory_updated.connect(populate_item_grid)

#	fills item grid based on array of ItemData

func populate_item_grid(_inventory_data):
	for child in item_grid.get_children():
		child.queue_free()
		
	for item_data in _inventory_data.item_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(_inventory_data.on_slot_clicked)
		slot.set_item_data(item_data)
