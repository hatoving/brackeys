extends Node2D

export var damage: float = 0

var timer = 0.5
var startTimer = false

var spedup = false

func _process(delta):
	if startTimer:
		timer -= delta
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0
	if timer <= 0:
		startTimer = false
		timer = 2
		
	if GlobalVars.climax && !spedup:
		damage += 10.5
		spedup = true

func _on_Hurtbox_body_entered(body):
	if body.get_name() == "Player":
		body.getHurt(damage, 150)
		
		startTimer = true
