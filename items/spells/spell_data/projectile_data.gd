extends SpellData
class_name ProjectileData

@export var max_speed: float
@export var initial_speed: float
@export var acceleration: float
@export var lifetime: float
@export var damage: int
@export var size: float
var scene = preload("res://items/spells/projectiles/base_projectile.tscn")
var direction : Vector2

@export_group("spawning")
@export var spawn_count : int = 1
@export var spawn_spread : float = 0

@export_group("bools") 							#TODO
@export var homing : bool = false
@export var peircing : bool = false
@export var tracking : bool = false
@export var orbiting : bool = false
