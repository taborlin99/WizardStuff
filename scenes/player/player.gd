extends Entity
class_name Player

@onready var state_machine = $StateMachine

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	if Input.is_action_just_pressed("click"): #this needs to go to state machine later
		cast_spell_chain()

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func get_spell_array():
	var spell_array = ["bolt","bomb","bolt"] 
	print(spell_array)
	return spell_array
	
func cast_spell_chain():
	var spell_array = get_spell_array()
	if Input.is_action_just_pressed("click"):
		var spell = load_spell(spell_array, 0)
		spell.global_position = self.global_position
		spell.rotation = get_angle_to(get_global_mouse_position())
		spell.init()
