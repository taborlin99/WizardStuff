extends Node2D
@onready var particles = $GPUParticles2D
var cast_distance = 20
var arc_length = 45
var swing_time = 0.5
var time : float = 0
var rotation_increment = (arc_length / swing_time)
var angle : float = 0

func _ready():
	particles.global_translate(Vector2(cast_distance, 0))

func _physics_process(delta):
	swing(delta, arc_length, swing_time)
	
func swing(delta, _arc_length, _swing_time):
	if time <= _swing_time:
		angle = angle + rotation_increment * delta
		time += delta
	else: 
		particles.emitting = false
	rotation = deg_to_rad(angle - (_arc_length/2))
	var p_dir = Vector2.RIGHT.rotated(rotation)
	particles.process_material.direction = Vector3(p_dir.x, p_dir.y, 0)
