extends Node2D

@export var player : CharacterBody2D
var inventory_open : bool = true

# ------------ OUTGOING SIGNALS -----------------

signal sig_input_direction(input_direction)
signal lmb()
signal rmb()
signal dash()
signal mouse_position(mouse_position)
signal toggle_inventory()		#
signal cast_spell_chain()		#

# ------------- INPUTS -------------------------

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		toggle_inventory.emit()
		inventory_open = not inventory_open
	if inventory_open == false:
		var direction : Vector2
		direction.x = Input.get_axis("move_left", "move_right")
		direction.y = Input.get_axis("move_up", "move_down")
		var input_direction = direction.normalized()
		if input_direction != Vector2.ZERO:
			sig_input_direction.emit(input_direction)
		else: 
			sig_input_direction.emit(Vector2.ZERO)
		
		if event.is_action_pressed("lmb"):
			lmb.emit()
			
		if event.is_action_pressed("lmb"):
			rmb.emit()

		if event.is_action_pressed("dash"):
			dash.emit()
			
		if event is InputEventMouseMotion:
			var m_position = get_global_mouse_position()
			mouse_position.emit(m_position)
