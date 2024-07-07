extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

@export var item_datas : Array[ItemData] 

func on_slot_clicked(index: int, button: int):
	inventory_interact.emit(self, index, button)

func swap_item_data(grabbed_item_data, index: int) -> ItemData:
	var new_grabbed_item = item_datas[index]
	item_datas[index] = grabbed_item_data
	inventory_updated.emit(self)
	return new_grabbed_item
