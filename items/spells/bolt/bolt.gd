extends SpellScene

@onready var bolt = $BoltParticles
@onready var bolt_trail = $BoltTrail

func _ready():
	print(data.direction)
	super()

func _physics_process(delta):
	if active == true:
		linear_movement(delta)

func on_spell_end():
	super()
	bolt.emitting = false
	bolt_trail.emitting = false
	await get_tree().create_timer(0.3).timeout #cleanup time
	queue_free()
