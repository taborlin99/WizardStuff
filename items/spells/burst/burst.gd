extends SpellScene
@onready var time : float = 0
@onready var arc_length = data.spell_area
@onready var rotation_increment : float = (arc_length / data.lifetime)
@onready var angle : float = 0
@onready var anchor = $Anchor
@onready var particles = $Anchor/GPUParticles2D

func _ready():
	super()

func _physics_process(delta):
	super(delta)
	#create_arc(delta)
	
func on_spell_end():
	var spawn_array = find_arc(direction, data.spawn_spread, data.spell_range, data.spawn_count)
	for spawn_location in spawn_array:
		pass
	super()
	
#func create_arc(delta):
	#if time <= data.lifetime:
		#angle += rotation_increment * delta
		#time += delta
	#var _rotation = deg_to_rad(angle - (arc_length/2))
	#var p_dir = direction.rotated(_rotation)
	#anchor.rotation = _rotation
	#particles.process_material.direction = Vector3(p_dir.x, p_dir.y, 0)
