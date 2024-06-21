extends CharacterBody2D

@onready var player = get_node(Constants.playerPath)
var speed = 60

func _on_detection_range_area_entered(area):
	print("something in area")
	if area.is_in_group("player_area"):
		$StateChart.send_event("player_entered")
		print("player detected")

func _on_idle_state_entered():
	print("slime_idle")

func _on_following_state_entered():
	print("slime_following")

func _on_following_state_physics_processing(delta):
	var direction = Vector2(player.global_position - global_position)
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
