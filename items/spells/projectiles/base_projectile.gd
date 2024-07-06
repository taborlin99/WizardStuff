extends CharacterBody2D

var data : ProjectileData

var speed : float = 0
var direction : Vector2 = Vector2.ZERO
var spell_chain
var index : int

var max_speed 
var acceleration
var initial_speed
var lifetime
var damage 
var size 
var timer
var timeout : bool = false

func initiate_spell():
	max_speed = data.max_speed
	acceleration = data.acceleration
	speed = data.initial_speed
	lifetime = data.lifetime
	damage = data.damage
	size = data.size
	start_timer()
	
func start_timer():
	await get_tree().create_timer(lifetime).timeout
	timeout = true

func _ready():
	initiate_spell()

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
	 #rudimentary spell spawning 
	#TODO add alternative spawning patterns, spawning multiple projs.
	if index < spell_chain.size():
		var data = spell_chain[index]
		var new_spell = data.scene.instantiate()
		new_spell.data = data
		new_spell.direction = direction
		new_spell.spell_chain = spell_chain
		new_spell.index = index + 1
		new_spell.global_position = global_position
		get_tree().root.add_child(new_spell)
	else:
		print("end spell chain")
