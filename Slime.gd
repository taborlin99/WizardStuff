extends CharacterBody2D

@export var nav_agent : Navigation
@onready var player = get_node(Constants.playerPath)
var speed = 20

func _on_detection_range_area_entered(area):
	if area.is_in_group("player_area"):
		$StateChart.send_event("player_entered")

func _on_idle_state_entered():
	pass

func _on_following_state_entered():
	pass

func _on_following_state_physics_processing(delta):
	var direction = nav_agent.path_to_player
	velocity = direction * speed
	move_and_slide()
