extends CharacterBody2D
class_name Entity

#Entity Attributes
@export var max_health : int
@export var current_health : int
@export var health_regen : int
@export var max_mana : int
@export var current_mana : int
@export var mana_regen : int
@export var strength : int
@export var agility : int
@export var intelligence : int
@export var max_speed : float 
@export var current_speed : float
@export var acceleration : float
#endregion

func regen_health():
	if current_health < max_health:
		if (current_health + health_regen) > max_health:
			current_health = max_health
		else: current_health = current_health + health_regen

func regen_mana():
	if current_mana < max_mana:
		if (current_mana + mana_regen) > max_mana:
			current_mana = max_mana
		else: current_mana = current_mana + mana_regen
		
func modify_mana(amount):
	var new_mana = current_mana + amount
	if (new_mana < 0): current_mana = 0
	if new_mana > max_mana: current_mana = max_mana
	else: current_mana += amount

func modify_health(amount):
	var new_health = current_health + amount
	if new_health < 0:
		current_health = 0
	if new_health > max_health:
		current_health = max_health
	else: current_health += amount
	
func load_spell(spell_array, index):
	var scene = load("res://scenes/spells/" + spell_array[index] + "/" + spell_array[index] + ".tscn")
	var scenenode = scene.instantiate()
	scenenode.index = index + 1 
	scenenode.spell_array = spell_array
	get_node("/root").add_child(scenenode)
	print(index)
	return scenenode

