extends CharacterBody2D

@export var animation_player : AnimationPlayer
@export var state : Node
@export var max_speed : float = 60
@export var dash_speed : float = 300
@export var dash_duration : float = 0.1
@export var cast_duration : float = 0.2
var mouse_position : Vector2
var mouse_direction : Vector2

var dash_direction : Vector2
var direction : Vector2 = Vector2.ZERO

func take_damage(amount): 		#			TODO modify health and enter hurt state
	pass

func _unhandled_input(event): #				gets normalized input direction
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	direction = direction.normalized()
	
	mouse_position = get_viewport().get_mouse_position()
	mouse_position.x = mouse_position.x - 960
	mouse_position.y = mouse_position.y - 540
	mouse_direction = mouse_position - self.position
	mouse_direction = mouse_direction.normalized()
	
func _physics_process(delta):#				always moving and colliding
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

func _on_walk_state_input(event):#			look for input
	if Input.is_action_just_pressed("click"):
		state.send_event("to_cast")
	if Input.is_action_just_pressed("roll"):
		state.send_event("to_dash")

func _on_walk_state_physics_processing(delta): # move player according to direction
	velocity = direction * max_speed
	var animation_direction = Static.animation_direction(direction)
	if animation_direction:
		var animation = "walk" + animation_direction
		animation_player.play(animation)
		
	if velocity == Vector2.ZERO and direction == Vector2.ZERO:
		state.send_event("to_idle")

func _on_dash_state_entered():
	$StateChart/Root/Dash/to_idle.delay_seconds = float(dash_duration)
	print("dash duraction ",dash_duration)

func _on_dash_state_physics_processing(delta):#	dash in direction
	if dash_direction == Vector2.ZERO:
		dash_direction = direction
		print("dash direction is: ",dash_direction)
	else:
		velocity = (dash_direction * dash_speed)
		
func _on_dash_state_exited():
	dash_direction = Vector2.ZERO

func _on_cast_state_entered():
	$StateChart/Root/Cast/to_idle.delay_seconds = cast_duration
	cast(mouse_direction)

func cast(direction):#						TODO add cast
	pass

