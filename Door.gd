extends Node2D

func _on_Hurtbox_body_entered(body):
	if GlobalVars.climax:
		if body.name == "Player":
			get_tree().change_scene("res://EpicEnding.tscn")
