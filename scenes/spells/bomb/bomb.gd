extends Projectile


func _physics_process(delta):
	standard_movement()
	move_and_slide()
	track_lifetime(delta)
