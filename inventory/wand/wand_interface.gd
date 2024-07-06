extends Control

var grabbed_item_data: ItemData

#signal set_spell_data(wand_data)

@onready var wand_inventory = $WandInventory
@onready var wand_data: WandData = wand_inventory.wand_data
@onready var grabbed_item = $GrabbedItem
const EMPTY = preload("res://items/item_data/empty.tres")

func _ready(): 
	update_grabbed_item()

func set_wand_inventory(wand_data: WandData):
	wand_inventory.set_wand_inventory(wand_data)
	wand_data.wand_interact.connect(on_wand_interact)
	#set_spell_data.emit(wand_data)

func _physics_process(delta):
	if grabbed_item.visible:
		grabbed_item.global_position = get_global_mouse_position() + Vector2(5, 5)

func on_wand_interact(wand_data: WandData, index: int, button: int):
	var item_data = wand_data.item_datas[index]
	if item_data.locked:
		return
	else:
		match [item_data.empty, grabbed_item_data, button]:
			[true, _, _]:
				grabbed_item_data = wand_data.drop_item_data(grabbed_item_data, index)
			[false, _, 1]:
				grabbed_item_data = wand_data.drop_item_data(grabbed_item_data, index)
	update_grabbed_item()

func update_grabbed_item():
	if grabbed_item_data:
		if grabbed_item_data.empty:
			grabbed_item.hide()
		else:
			grabbed_item.show()
			grabbed_item.set_slot_data(grabbed_item_data)
	else: grabbed_item_data = EMPTY
	
