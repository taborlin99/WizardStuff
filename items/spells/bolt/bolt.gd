extends SpellScene

@onready var bolt = $BoltParticles
@onready var bolt_trail = $BoltTrail
var desired_speed : float = 0
var desired_direction : Vector2 = Vector2.ZERO
var homing_direction : Vector2 = Vector2.ZERO
var tracking_direction : Vector2 = Vector2.ZERO

func _ready():
	super()
	desired_speed = data.initial_speed
	desired_direction = direction

func _physics_process(delta):
	super(delta)
	if active == true:
		handle_movement(delta)

func handle_movement(delta):
	if data.homing == true:
		pass
		#find homing direction but no targets yet. using area body2D

	if data.mouse_tracking == true:
		tracking_direction = (get_global_mouse_position() - global_position).normalized()

	desired_speed = move_toward(desired_speed, data.max_speed, data.acceleration * delta)
	if data.mouse_tracking == true:
		desired_direction = desired_direction.move_toward(tracking_direction, data.tracking_strength)
	if data.homing == true:
		desired_direction = desired_direction.move_toward(homing_direction, data.homing_strength)
	direction = desired_direction
	velocity = desired_direction * desired_speed
	move_and_slide()

func on_spell_end():
	super()
	bolt.emitting = false
	bolt_trail.emitting = false
	await get_tree().create_timer(0.3).timeout #cleanup time
	queue_free()
