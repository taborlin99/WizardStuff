extends Resource
class_name WandData

const EMPTY = preload("res://items/item_data/empty.tres")

signal wand_updated(wand_data: WandData)
signal wand_interact(wand_data: WandData, index: int, button: int)

@export var item_datas: Array[ItemData]

func on_slot_clicked(index: int, button: int) -> void:
	wand_interact.emit(self, index, button)

func drop_item_data(grabbed_item_data, index) -> ItemData:
	var item_data = item_datas[index]
	item_datas[index] = grabbed_item_data
	wand_updated.emit(self)
	if item_data:
		return item_data
	else:
		return null
