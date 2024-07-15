extends CharacterBody2D
class_name ProjectileScene

var active : bool = false
var data : SpellData
var spell_chain : Array[SpellData]
var index : int

@onready var initial_location : Vector2

@onready var initial_direction : Vector2
@onready var desired_direction : Vector2
@onready var homing_direction : Vector2
@onready var tracking_direction : Vector2

@onready var desired_speed : float

@onready var spawn_timer = data.spawn_rate

@export var scene : PackedScene

func _ready():
	active = true
	desired_speed = data.initial_speed
	desired_direction = initial_direction
	start_lifetime_timer(data.lifetime)
	on_spell_cast()

func start_lifetime_timer(lifetime):
	await get_tree().create_timer(lifetime).timeout
	on_spell_end()

func _physics_process(delta):
	pass

func linear_movement(delta):
	desired_speed = move_toward(desired_speed, data.max_speed, data.acceleration * delta)
	if data.homing == true:
		pass#TODO
	if data.mouse_tracking == true:
		tracking_direction = (get_global_mouse_position() - global_position).normalized()
	if data.mouse_tracking == true:
		desired_direction = desired_direction.move_toward(tracking_direction, data.tracking_strength)
	if data.homing == true:
		desired_direction = desired_direction.move_toward(homing_direction, data.homing_strength)
	velocity = desired_direction * desired_speed
	move_and_slide()

func on_spell_cast():
	#spot for on cast effects (kinda obvious huh)
	pass

func on_spell_hit():
	#TODO handle dealing damage to damageable actors, or unique spell responses
	pass

func on_spell_end():
	if data.spawn_on_end == true and index < spell_chain.size():
		cast_arc(find_arc(desired_direction, data.spawn_spread, data.spell_range, data.spawn_count))
	active = false

func find_arc(dir : Vector2, spread : float, distance : float, count: int):
	var output = []
	for i in count:
		var angle = (spread/count) * i
		output.append(dir.rotated(deg_to_rad(angle)) * distance)
	return output

func cast_arc(spawn_array):
	for spawn_position in spawn_array:
		var desired_location = global_position + spawn_position
		var direction = (desired_location - global_position).normalized()
		cast_spell(spell_chain, index, desired_location, direction)

func cast_spell(spell_chain, index, location, direction):
	var spell_data = spell_chain[index]
	var new_spell = spell_data.scene.instantiate()
	new_spell.data = spell_data
	new_spell.spell_chain = spell_chain
	new_spell.index = index + 1
	new_spell.global_position = location
	new_spell.initial_direction = direction
	get_tree().root.add_child(new_spell)
