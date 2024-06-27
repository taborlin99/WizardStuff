extends CharacterBody2D

#this is like a FSM except if it were awesome

@export var animation_player : AnimationPlayer
@export var state : Node
@export var max_speed : float = 60
@export var dash_speed : float = 300
@export var dash_duration : float = 0.1
@export var cast_duration : float = 0.2
@export var casting_move_speed : float = 30

var mouse_position : Vector2
var mouse_direction : Vector2
var input_direction : Vector2
var direction : Vector2 
var speed = max_speed

func take_damage(amount): 		#			TODO modify health and enter hurt state
	pass

func _unhandled_input(event): #				gets normalized input direction
	input_direction.x = Input.get_axis("move_left","move_right")
	input_direction.y = Input.get_axis("move_up","move_down")
	input_direction = input_direction.normalized()
	
	mouse_position = get_viewport().get_mouse_position()
	mouse_position.x = mouse_position.x - 960
	mouse_position.y = mouse_position.y - 540
	mouse_direction = mouse_position - self.position
	mouse_direction = mouse_direction.normalized()
	
func _physics_process(delta):#				always moving and colliding based on "speed" and "direction"
	velocity = speed * direction
	move_and_collide(velocity * delta)

func _on_idle_state_entered():#				play idle animation
	#animation_player.play("idle")
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO or velocity != Vector2.ZERO:
		state.send_event("to_walk")

func _on_idle_state_input(event):#			wait for player input
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		state.send_event("to_walk")
	if Input.is_action_just_pressed("click"):
		state.send_event("to_cast")
	if Input.is_action_just_pressed("roll"):
		state.send_event("to_dash")

func _on_walk_state_entered():#				sets speed to base speed
	speed = max_speed

func _on_walk_state_input(event):#			look for input
	if Input.is_action_just_pressed("click"):
		state.send_event("to_cast")
	if Input.is_action_just_pressed("roll"):
		state.send_event("to_dash")

func _on_walk_state_physics_processing(delta): # move player according to direction
	direction = input_direction
	var animation_direction = Static.animation_direction(direction)
	
	if animation_direction:
		var animation = "walk" + animation_direction
		animation_player.play(animation)
		
	if velocity == Vector2.ZERO and direction == Vector2.ZERO:
		state.send_event("to_idle")

func _on_dash_state_entered():#				gets direction and changes speed
	$StateChart/Root/Dash/to_idle.delay_seconds = float(dash_duration)
	direction = input_direction
	speed = dash_speed

func _on_dash_state_exited():#				sets speed and direction back to base,  
	direction = input_direction
	speed = max_speed

func _on_cast_state_entered():# 			move slow when casting, set delay time
	speed = casting_move_speed
	$StateChart/Root/Cast/to_idle.delay_seconds = cast_duration
	cast(mouse_direction)

func _on_cast_state_exited():
	speed = max_speed

func _on_cast_state_physics_processing(delta):
	direction = input_direction
	var animation_direction = Static.animation_direction(mouse_direction)
	if animation_direction:
		var animation = "walk" + animation_direction
		animation_player.play(animation)

	if velocity == Vector2.ZERO and direction == Vector2.ZERO:
		state.send_event("to_idle")

func cast(direction):#						TODO feel free to replace this to call on wand in the future
	var spell_scene = preload("res://scenes/spells/bolt/bolt.tscn")
	var spell_instance = spell_scene.instantiate()
	spell_instance.global_position = self.global_position
	spell_instance.rotation = mouse_direction.angle()
	get_tree().root.add_child(spell_instance)
