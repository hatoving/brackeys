extends Sprite

export var dir = -1
export var speed = 20

var velocity = Vector2.ZERO

onready var rand = RandomNumberGenerator.new()

var fallSpeed = 6

func _ready():
	velocity.y = -1
	rand.randomize()
	
	frame = rand.randf_range(0, 2)
	
func _process(delta):
	global_position.x += (dir * speed) * delta
	velocity.y += fallSpeed * delta
	
	rotation += (dir * speed) * delta
	
	global_position.x += velocity.x
	global_position.y += velocity.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
