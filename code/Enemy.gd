extends Node2D

export var damage: float = 0

func _on_Hurtbox_body_entered(body):
	if body.get_name() == "Player":
		body.getHurt(damage, 100)
