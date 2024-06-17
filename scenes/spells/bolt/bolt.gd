extends Projectile


func _physics_process(delta):
	standard_movement()
	track_lifetime(delta)
	move_and_slide()

func _on_hurtbox_body_entered(body):
	$CollisionShape2D.set_deferred("disabled", true)
	if body.is_in_group("enemies"):
		body.spell_hit(damage)
	self.hide()
		
