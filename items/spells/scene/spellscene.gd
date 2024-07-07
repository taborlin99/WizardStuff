extends CharacterBody2D
class_name SpellScene

var data : SpellData

var speed : float = 0
var direction : Vector2 = Vector2.ZERO
var spell_chain : Array
var index : int

var max_speed 		#
var acceleration	#
var initial_speed	#
var lifetime		#
var damage 			#
var size 
var spawn_count
var spawn_spread

var timer
var timeout : bool = false
#var trigger_types = ["circular", "",""]
func _ready():
	initiate_spell()

func initiate_spell():
	max_speed = data.max_speed
	acceleration = data.acceleration
	speed = data.initial_speed
	lifetime = data.lifetime
	damage = data.damage
	size = data.size
	spawn_count = data.spawn_count
	spawn_spread = data.spawn_spread
	start_timer()
	
func start_timer():
	await get_tree().create_timer(lifetime).timeout
	timeout = true

func _physics_process(delta):
	speed = move_toward(speed, max_speed, acceleration * delta)
	velocity = direction * speed
	move_and_collide(velocity * delta)
	if timeout == true:
		spell_end()
		
func spell_end():
	cast_spell_chain(spell_chain, index, direction)
	queue_free()

func cast_spell_chain(spell_chain, index, direction):
	if index < spell_chain.size():
		var data = spell_chain[index]
		var angle_increment = spawn_spread/spawn_count
		var initial_angle = -angle_increment/2
		for i in range(spawn_count):
			var angle = initial_angle + (i * angle_increment)
			var new_spell = data.scene.instantiate()
			new_spell.data = data
			new_spell.direction = direction.rotated(angle)
			new_spell.spell_chain = spell_chain
			new_spell.index = index + 1
			new_spell.global_position = global_position
			get_tree().root.add_child(new_spell)
	else:
		pass
