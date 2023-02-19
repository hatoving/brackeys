extends Node2D

export var damage: float = 0
export var speed: float = 2.5

export var xdir = 1
var ydir = 1

var spedup = false

func _process(delta):
	global_position.x += speed * xdir
	
	if GlobalVars.climax && !spedup:
		if xdir == 1: 
			xdir = -1
		else: 
			xdir = 1
		
		speed += 3.5
		spedup = true
	
	if xdir == 1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func _on_Hurtbox_body_entered(body):
	xdir = -1 if xdir == 1 else 1
	
	if body.get_name() == "Player":
		body.getHurt(damage, 100)
