extends CharacterBody2D
class_name SpellScene

var active : bool = false
var data : SpellData
var direction : Vector2 = Vector2.ZERO
var spell_chain : Array[SpellData]
var index : int
@onready var spawn_timer = data.spawn_rate

@export var scene : PackedScene

func _ready():
	active = true
	start_lifetime_timer(data.lifetime)
	on_spell_cast()

func start_lifetime_timer(lifetime):
	await get_tree().create_timer(lifetime).timeout
	on_spell_end()

func _physics_process(delta):
	if data.spawn_persistent == true:
			spawn_persistent(delta)

func on_spell_cast():
	#spot for on cast effects (kinda obvious huh)
	pass

func on_spell_hit():
	#TODO handle dealing damage to damageable actors, or unique spell responses
	pass

func on_spell_end():
	active = false
	if data.spawn_on_end == true:
		cast_spell_chain_arc()
	

func cast_spell_chain_arc():
	cast_arc(spell_chain, index, direction, data.spawn_count, data.spawn_spread)

func cast_arc(_spell_chain, _index, _direction, spawn_count, spawn_spread):
	if index < spell_chain.size():
		var new_data = _spell_chain[_index]
		var spawn_arc = deg_to_rad(spawn_spread)
		var angle_increment = spawn_arc / (spawn_count - 1.001)
		var initial_angle = -spawn_arc / 2
		for i in range(spawn_count):
			var angle = initial_angle + (i * angle_increment)
			var new_spell = data.scene.instantiate()
			new_spell.data = new_data
			new_spell.direction = _direction.rotated(angle)
			new_spell.spell_chain = _spell_chain
			new_spell.index = _index + 1
			new_spell.global_position = global_position
			get_tree().root.add_child(new_spell)
	else:
		return

func spawn_persistent(delta):
	if active == true:
		spawn_timer -= delta
		if spawn_timer <= 0:
			spawn_timer = data.spawn_rate
			cast_spell_chain_arc()
