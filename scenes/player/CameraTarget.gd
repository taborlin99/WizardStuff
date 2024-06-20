class_name CameraTarget
extends Node2D

@onready var player = get_node("/root/Main/PixelPerfectRendering/SubViewport/Game/player")


func _ready() -> void:
	# Attempt to register with controller.
	var result: Node = get_tree().get_first_node_in_group("camera_controllers")
	if result and result is CameraController:
		result.register_target(self)

#func _physics_process(delta):
	#var player_position = player.global_position
	#var mouse_position = get_local_mouse_position()
	##mouse_position.x = mouse_position.x/6
	##mouse_position.y = mouse_position.y/6
	#var desired_position = Vector2((player_position.x + mouse_position.x) / 2, (player_position.y + mouse_position.y) / 2)
	#print("player pos ",player_position)
	#print("cursor pos ",mouse_position)
	#self.position = desired_position
	#print("desired ",desired_position)
