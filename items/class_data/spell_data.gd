extends ItemData
class_name SpellData

@export var mana_cost : int

@export var max_speed: float
@export var initial_speed: float
@export var acceleration: float
@export var lifetime: float
@export var damage: int
@export var size: float
@export var scene : PackedScene
var direction : Vector2

@export_group("spawning")
@export var spawn_count : int = 1
@export var spawn_spread : float = 0

@export_group("properties") 							#TODO
@export var homing : bool = false
@export var peircing : bool = false
@export var tracking : bool = false
@export var orbiting : bool = false
