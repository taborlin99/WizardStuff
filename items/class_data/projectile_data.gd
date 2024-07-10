extends SpellData
class_name ProjectileData
	
@export_group("movement")
@export var max_speed: float
@export var initial_speed: float
@export var acceleration: float

@export_group("projectile properies")
@export_group("homing")
@export var homing : bool = false
@export var homing_strength : float
@export_group("piercing")
@export var piercing : bool = false
@export var piercing_number : int
@export_group("bouncing")
@export var bouncing : bool = false
@export var bounces : int
@export_group("orbiting")
@export var orbiting : bool = false
@export var orbit_speed : float
@export var orbit_distance : float
@export_group("mouse_tracking")
@export var mouse_tracking : bool = false
@export var tracking_strength : float
