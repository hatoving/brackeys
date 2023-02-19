extends Node2D

var amount = 5
var timer = 0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if timer < amount:
		timer += delta
	else:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
