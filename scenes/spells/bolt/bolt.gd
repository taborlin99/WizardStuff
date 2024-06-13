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
	if index < spell_array.size():
		cast_spell_chain()
	print(index)
	print(spell_array.size())
	queue_free()
		
func cast_spell_chain():
	var sp1 = load_spell(spell_array, index + 1)
	sp1.global_position = self.global_position
	print("test")
