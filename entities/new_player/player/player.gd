extends CharacterBody2D

signal toggle_inventory()
signal cast_spell_chain()

@export var player_wand: WandData
var cooldown = 1

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var dash_speed : float = 200
@export var dash_duration : float = 1

@export var state_chart : StateChart
@export var animation_player : AnimationPlayer

var input_direction : Vector2 = Vector2.ZERO
var movement_direction : Vector2 = Vector2.ZERO
var mouse_direction : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed : float = 0

func _physics_process(delta):
	var desired_velocity = direction * speed
	velocity = velocity.move_toward(desired_velocity, acceleration)
	move_and_collide(velocity * delta) 

#  ------------ INPUT SIGNALS ------------

func _on_player_input_toggle_inventory():
	state_chart.send_event("to_idle")
	toggle_inventory.emit()

func _on_player_input_sig_input_direction(new_direction):
	input_direction = new_direction
	state_chart.send_event("to_walk")

func _on_player_input_lmb():
	state_chart.send_event("to_cast")

func _on_player_input_mouse_position(mouse):
	var mouse_position = mouse
	mouse_direction = mouse_position - self.global_position
	mouse_direction = mouse_direction.normalized()

func _on_player_input_rmb():
	pass

func _on_player_input_dash():
	state_chart.send_event("to_dash")

# ----------- STATE MANAGEMENT ---------------

func _on_idle_state_entered():
	direction = Vector2.ZERO

func _on_walk_state_physics_processing(delta):
	direction = input_direction
	speed = move_speed
	if direction == Vector2.ZERO:
		state_chart.send_event("to_idle")

func _on_dash_state_entered():
	speed = dash_speed
	direction = input_direction
	$StateChart/CompoundState/Dash/Transition.delay_seconds = dash_duration
	state_chart.send_event("to_walk")

func _on_cast_state_entered():
	direction = input_direction
	speed = move_speed
	cast_spell()
	await get_tree().create_timer(cooldown).timeout
	state_chart.send_event("to_idle")
	
func cast_spell() -> void:
	var cast_direction : Vector2 = get_global_mouse_position() - global_position
	cast_direction = cast_direction.normalized()
	cast_spell_chain.emit(0, cast_direction)



