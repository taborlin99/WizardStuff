extends Entity

@onready var direction : Vector2 = Vector2.ZERO
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	pass
	
func player_movement():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = velocity.move_toward(direction * max_speed, acceleration)
	move_and_slide()

func _process(delta):
	cast_spell_chain()
	player_movement()

func get_spell_array():
	var spell_array = ["bolt"] 
	return spell_array
	
func cast_spell_chain():
	var spell_array = get_spell_array()
	if Input.is_action_just_pressed("click"):
		var spell = load_spell(spell_array, 0)
		spell.global_position = self.global_position
		spell.rotation = get_angle_to(get_global_mouse_position())
		spell.init()
		
enum state
{
	STATE_IDLE,
	STATE_WALKING
	}
