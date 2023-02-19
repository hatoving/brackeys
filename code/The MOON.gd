extends Node2D

var timer = 0

func _process(delta):
	timer += delta
	global_position.y += sin(timer) / 12
