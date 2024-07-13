extends SpellScene
@onready var particles = $Anchor/GPUParticles2D
@onready var anchor = $Anchor
@onready var time : float = 0
@onready var arc_length = data.spell_area
@onready var rotation_increment : float = (arc_length / data.lifetime)
@onready var angle : float = 0

func _ready():
	super()
	particles.position = position + (direction * data.spell_range)

func _physics_process(delta):
	super(delta)
	swing_animation(delta)

func swing_animation(delta):
	if time <= data.lifetime:
		angle += rotation_increment * delta
		time += delta
	var _rotation = deg_to_rad(angle - (arc_length/2))
	var p_dir = Vector2.RIGHT.rotated(_rotation)
	particles.process_material.direction = Vector3(p_dir.x, p_dir.y, 0)
	anchor.rotation = _rotation

func on_spell_end():
	position = position + (direction * data.spell_range)
	super()
	particles.emitting = false
