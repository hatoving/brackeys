extends ColorRect

func _process(delta):
	modulate = lerp(modulate, Color(0, 0, 0, 0), delta * 2)
