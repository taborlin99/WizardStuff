extends PanelContainer

signal update_spell_chain(spellchain)

@onready var player = $"../../../Player"				#should be constant
@onready var item_grid = $MarginContainer/ItemGrid
@onready var inventory_data = player.player_wand
var spell_chain : Array[SpellData] 

const Slot = preload("res://inventory/interface/slot/slot.tscn")

func _ready():
	populate_item_grid(inventory_data)
	inventory_data.inventory_updated.connect(populate_item_grid)

#	fills item grid based on array of ItemData

func populate_item_grid(_inventory_data):
	for child in item_grid.get_children():
		child.queue_free()
		spell_chain.resize(0)
		
	for item_data in _inventory_data.item_datas:			#instantiate slots of ItemData, set data, and connect to signals
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(_inventory_data.on_slot_clicked)
		slot.set_item_data(item_data)
		get_spell_chain(item_data)

#	construct array containing only SpellData, and signal to WandActor

func get_spell_chain(item_data) -> void:
	if item_data is SpellData:
			spell_chain.append(item_data)
	update_spell_chain.emit(spell_chain)
