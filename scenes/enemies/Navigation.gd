extends Node2D
class_name Navigation

var player = null
var new_nav_agent : NavigationAgent2D
var nav = NavigationAgent2D
var path_to_player : Vector2
var test_var = 1001

	#creates new NavAgent, and adds it as child
func _ready():
	player = get_node(Constants.playerPath)
	create_nav()

func create_nav():
	var new_nav_agent = NavigationAgent2D.new()
	new_nav_agent.target_position = player.global_position
	add_child(new_nav_agent)

func _physics_process(delta):
	if is_instance_valid(NavigationAgent2D) == true:
		nav = get_child(0)
		nav.target_position = player.global_position
		path_to_player = to_local(nav.get_next_path_position())
		path_to_player = path_to_player.normalized()
