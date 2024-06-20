extends Node2D
@export var animation : Node

func _ready():
	animation.play("coin_spin")

func _process(delta):
	pass
