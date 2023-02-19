extends Node2D

export var damage: float = 0
export var speed: float = 2.5

var dir = 1

var spedup = false

func _process(delta):
	global_position.x += speed * dir
	
	if GlobalVars.climax && !spedup:
		speed += 1.5
		spedup = true

func _on_Hurtbox_body_entered(body):
	if body.get_name() == "Player":
		body.getHurt(damage, 50)
		
	queue_free()
