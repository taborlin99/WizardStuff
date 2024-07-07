extends Node2D

@onready var player = $"../Player"
@onready var wand_inventory = $"../CanvasLayer/InventoryInterface/WandInventory"

var spell_chain : Array[SpellData]

func _ready():
	wand_inventory.update_spell_chain.connect(on_update_spell_chain)
	player.cast_spell_chain.connect(on_cast_spell_chain)

func on_update_spell_chain(spell_data):
	spell_chain = spell_data

func on_cast_spell_chain(index : int, location : Vector2, direction: Vector2):
	if index < spell_chain.size():
		var data = spell_chain[index]
		var new_spell = data.scene.instantiate()
		new_spell.data = data
		new_spell.direction = direction
		new_spell.spell_chain = spell_chain
		new_spell.index = index + 1
		get_tree().root.add_child(new_spell)
