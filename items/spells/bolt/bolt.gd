extends SpellScene

var active : bool = false
@onready var spawn_timer = data.spawn_rate

func _ready():
	super()
	active = true
	velocity = direction * data.initial_speed

func _physics_process(delta):
	velocity = velocity.move_toward(data.direction * data.max_speed, data.acceleration * delta)
	move_and_slide()
	if data._spawn_persistent == true:
		spawn_persistent(delta)

func on_spell_end():
	active = false
	if data.spawn_on_end == true:
		cast_spell_chain_arc()
	self.hide()
	await get_tree().create_timer(1).timeout #cleanup time
	queue_free()
	
func spawn_persistent(delta):
	if active == true:
		spawn_timer -= delta
		if spawn_timer <= 0:
			spawn_timer = data.spawn_rate
			cast_spell_chain_arc()
