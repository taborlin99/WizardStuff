extends Control

@onready var wand_inventory = $WandInventory
@onready var pouch_inventory = $PouchInventory

@onready var player = $"../../Player"				#TODO constant
@onready var grabbed_item = $GrabbedItem

const EMPTY = preload("res://items/util/empty.tres")

var grabbed_item_data: ItemData

#####################  Manage child Inventories, and "grabbed item" ###################

func _ready():
	player.toggle_inventory.connect(toggle_inventory)
	wand_inventory.inventory_data.inventory_interact.connect(on_inventory_interact)
	pouch_inventory.inventory_data.inventory_interact.connect(on_inventory_interact)
	grabbed_item_data = EMPTY

func toggle_inventory():
	self.visible = not self.visible									#possibly doesnt have to go through player

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int):
	if inventory_data.item_datas[index].locked == false:
		grabbed_item_data = inventory_data.swap_item_data(grabbed_item_data, index)
		update_grabbed_item()
	else:
		pass

func update_grabbed_item() -> void:
	grabbed_item.set_item_data(grabbed_item_data)
	if grabbed_item_data.empty == true:
		grabbed_item.hide()
	if grabbed_item_data.empty == false:
		grabbed_item.show()
	
func _physics_process(delta):
	if grabbed_item:
		grabbed_item.global_position = get_global_mouse_position() + Vector2(5,5)
