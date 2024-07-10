extends ItemData
class_name SpellData

@export var mana_cost : int
@export var size: float
@export var scene : PackedScene
@export var damage : int
@export_range(0, 10, 0.1) var lifetime : float
var direction : Vector2

@export_group("spawn on end")
@export var spawn_on_end : bool = true
@export var spawn_count : int = 1
@export_range(0, 360, 1) var spawn_spread : int = 0
@export_group("spawn persistent")
@export var spawn_persistent : bool = false
@export var spawn_rate : float
