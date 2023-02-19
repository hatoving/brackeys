extends Node2D

export var damage: float = 0
export var speed: float = 2.5

var dir = 1
var velocity = Vector2(0, 0)

var player
var spedup = false

func _ready():
	print(player)
	$Hurtbox/Sprite.flip_h = false if dir == 1 else true

func _process(delta):
	velocity = global_position.direction_to(player.global_position)
	
	global_position.x += velocity.x * speed
	global_position.y += velocity.y * speed
	
	var dir = (player.global_position - global_position)
	var angleTo = $Hurtbox/Sprite.transform.x.angle_to(dir)
	$Hurtbox/Sprite.rotate(sign(angleTo) * min (delta *  speed * 4, abs (angleTo)))
	
	if GlobalVars.climax && !spedup:
		speed += 2.5
		spedup = true

func _on_Hurtbox_body_entered(body):
	if body.get_name() == "Player":
		body.getHurt(damage, 259)
		queue_free()
	
	if !GlobalVars.climax:
		queue_free()
