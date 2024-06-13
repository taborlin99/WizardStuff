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
	
func get_spell_array():
	var spell_array = ["bolt", "bolt", "bolt"] 
	return spell_array
	
func cast_spell_chain():
	var spell_array = get_spell_array()
	var sp1 = load_spell(spell_array[1])
	sp1.global_position = self.global_position
	sp1.rotation = self.rotation
