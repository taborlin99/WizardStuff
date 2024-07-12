extends SpellScene
@onready var node_2d = $Node2D
@onready var particles = $Node2D/GPUParticles2D

func _ready():
	super()
	particles.translate(Vector2(data.range, 0))

