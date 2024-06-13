extends CharacterBody2D
class_name Projectile

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


func load_spell(spell_array, index):
	self.index = index
	self.spell_array = spell_array 
	var scene = load("res://scenes/spells/" + spell_array[index] + "/" + spell_array[index] + ".tscn")
	var scenenode = scene.instantiate()
	scenenode.index = index
	scenenode.spell_array = spell_array
	get_node("/root").add_child(scenenode)
	return scenenode
