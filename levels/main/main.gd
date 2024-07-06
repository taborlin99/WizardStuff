extends Node2D

@onready var player = $Player
@onready var wand_interface = $UI/WandInterface


func _ready():
	wand_interface.set_wand_inventory(player.player_wand)
	player.toggle_inventory.connect(toggle_inventory)
	
func toggle_inventory():
	wand_interface.visible = not wand_interface.visible
