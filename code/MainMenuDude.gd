extends Sprite

export var randomShakeStr : float = 38
export var shakeDecayRate : float = 5

onready var rand = RandomNumberGenerator.new()

var shake_strength = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	shake_strength = randomShakeStr
	rand.randomize()
	
func _process(delta):
	shake_strength = lerp(shake_strength, shake_strength, shakeDecayRate * delta)
	offset = get_random_offset()

func get_random_offset():
	return Vector2 (
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
