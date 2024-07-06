extends CharacterBody2D

signal toggle_inventory()
signal cast_spell_chain()


@export var player_wand: WandData #placeholder wand array



func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		toggle_inventory.emit()
	if event.is_action_pressed("lmb"):
		cast_spell()

func cast_spell() -> void:
	var cast_direction : Vector2 = get_global_mouse_position() - global_position
	cast_direction = cast_direction.normalized()
	cast_spell_chain.emit(0, cast_direction)
