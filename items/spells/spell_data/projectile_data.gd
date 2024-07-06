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
