extends PanelContainer
class_name WandInventory

@onready var player = $"../../../Player"
const Slot = preload("res://inventory/slot/slot.tscn")
var wand_data = preload("res://items/wands/test_wand.tres")
var spell_chain = []
@onready var item_grid = $MarginContainer/ItemGrid

func _ready():
	player.cast_spell_chain.connect(on_cast_spell_chain)

func set_wand_inventory(wand_data: WandData):
	populate_spell_grid(wand_data)
	wand_data.wand_updated.connect(populate_spell_grid)

func populate_spell_grid(wand_data) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		spell_chain.resize(0)
		
	for item_data in wand_data.item_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(wand_data.on_slot_clicked)
		if item_data:
			slot.set_slot_data(item_data)
		if not item_data.empty and not item_data.locked:
			spell_chain.append(item_data)

func on_cast_spell_chain(index, direction):				#this is here just "on_""" is a nice way to remember what is called by signals
	cast_spell_chain(spell_chain, index, direction)

func cast_spell_chain(spell_chain, index, direction):
	if index < spell_chain.size():
		var data = spell_chain[index]
		var new_spell = data.scene.instantiate()
		new_spell.data = data
		new_spell.direction = direction
		new_spell.spell_chain = spell_chain
		new_spell.index = index + 1
		get_tree().root.add_child(new_spell)
		print(index, spell_chain.size())
	else: 
		print("end spell chain")
