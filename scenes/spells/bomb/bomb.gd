extends Projectile
	
func _ready():
	pass
	
func _physics_process(delta):
	local_rotation = Vector2.RIGHT.rotated(rotation)
	velocity = velocity.move_toward(local_rotation * max_speed, acceleration)
	move_and_slide()
	
	lifetime -= delta
	if lifetime <= delta:
		projectile_expired()
	
func projectile_expired():
	print("free")
	
	queue_free()
