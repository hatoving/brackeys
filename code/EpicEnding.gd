extends Node2D

var timer = 0

export(AudioStream) var endingSfx

func _ready():
	$AudioStreamPlayer.stream = endingSfx
	$AudioStreamPlayer.play()
	MusManager.stop()

func _process(delta):
	timer += delta
	
	if timer > 7.5:
		get_tree().change_scene("res://Menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
