extends CharacterBody2D
class_name Projectile

var spell_ready : bool
@onready var index : int
@onready var spell_array : Array
@onready var local_rotation : Vector2 
@export var initial_speed : float
@export var max_speed : float
@export var acceleration : float
@export var lifetime: float
@export var cooldown : float
@export var mana_cost : float
@export var size : float
@export var damage : float
@export var bounces : int
@export var peircing : bool


func init():
	velocity = (Vector2.RIGHT.rotated(rotation) * initial_speed)
	
func standard_movement():
	local_rotation = Vector2.RIGHT.rotated(rotation)
	velocity = velocity.move_toward(local_rotation * max_speed, acceleration)
	
func load_spell(spell_array, index):
	var scene = load("res://scenes/spells/" + spell_array[index] + "/" + spell_array[index] + ".tscn")
	var scenenode = scene.instantiate()
	scenenode.index = index + 1
	scenenode.spell_array = spell_array
	get_node("/root").add_child(scenenode)
	print(index)
	return scenenode
	
	
func cast_spell_chain():
	if index < spell_array.size():
		var spell = load_spell(spell_array, index)
		spell.global_position = self.global_position
		spell.rotation = self.global_rotation
		spell.init()
		
func projectile_expired():
	cast_spell_chain()
	queue_free()

func track_lifetime(delta):
	lifetime -= delta
	if lifetime <= 0:
		projectile_expired()
