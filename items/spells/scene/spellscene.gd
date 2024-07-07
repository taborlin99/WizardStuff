extends CharacterBody2D
class_name SpellScene

var data : SpellData

##			COULD USE SOME HELP WITH THIS. OPTIONS I'M CONSIDERING

##		1.	Each spell gets its own custom scene, using the same spread of input data 
##			and acting accordingly

##		2.	Each spell inherits from a base spell class, that would just be a dumping spot for
##			most methods/behaviors a spell would need. This seems ok but could get messy

##		3. Each spell "type" (projectile, instant/melee, summon, etc) has a scene

##		4. composition: each spell creates nodes based on their resouce data, that handle:
##			- hitbox, art/animation, flight path, summoning pattern, etc as needed. 
##			this seems like the preffered** approach but IDK where to start 

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
var scene : PackedScene

var timer
var timeout : bool = false


func _ready():
	initiate_spell()

func initiate_spell():
	max_speed = data.max_speed			#This whole thing feels like it could be a loop or something
	acceleration = data.acceleration
	speed = data.initial_speed
	lifetime = data.lifetime
	damage = data.damage
	size = data.size
	spawn_count = data.spawn_count
	spawn_spread = data.spawn_spread
	scene = data.scene
	start_timer()

func start_timer():
	await get_tree().create_timer(lifetime).timeout
	spell_end()
	
func _physics_process(delta):
	speed = move_toward(speed, max_speed, acceleration * delta)
	velocity = direction * speed
	move_and_collide(velocity * delta)

func spell_end():
	cast_spell_chain(spell_chain, index, direction)
	queue_free()

func cast_spell_chain(spell_chain, index, direction):
	if index < spell_chain.size():
		var data = spell_chain[index]
		var spawn_arc = deg_to_rad(spawn_spread)
		var angle_increment = spawn_arc / (spawn_count -1.0001)
		var initial_angle = -spawn_arc / 2
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
