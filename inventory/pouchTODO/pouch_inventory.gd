extends PanelContainer
class_name PouchInventory

@onready var player = $"../../../Player"
const Slot = preload("res://inventory/slot/slot.tscn")
var wand_data = preload("res://items/wands/test_wand.tres")
@onready var item_grid = $MarginContainer/ItemGrid
@export var pouch_inventory : WandData
const EMPTY = preload("res://items/item_data/empty.tres")

func _ready():
	set_pouch_clear()
	populate_pouch_grid(wand_data)

func set_wand_inventory(wand_data: WandData):
	#populate_spell_grid(wand_data)
	wand_data.wand_updated.connect(populate_pouch_grid)

func populate_pouch_grid(wand_data) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for item_data in wand_data.item_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(wand_data.on_slot_clicked)
		if item_data:
			slot.set_slot_data(item_data)

func set_pouch_clear():
	for item_data in wand_data.item_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(wand_data.on_slot_clicked)
		slot.set_slot_data(EMPTY)
