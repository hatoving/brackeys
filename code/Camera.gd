extends Camera2D

export(NodePath) var player
export var camOffset = -45

export var randomShakeStr : float = 38
export var shakeDecayRate : float = 5

onready var rand = RandomNumberGenerator.new()

var shake_strength = 0.0
var climaxShake_strength = 0.0
var infiniteShaking = false

var savedYPos = 370.591919
var resetYPos = false

func _ready():
	savedYPos = get_node(player).global_position.y - 45
	rand.randomize()

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if get_node(player).hurt:
		if resetYPos: resetYPos = false
		global_position.y = get_node(player).global_position.y
		resetYPos = true
		
		if resetYPos:
			savedYPos = get_node(player).global_position.y + camOffset
	else:
		if resetYPos:
			resetYPos = false

		global_position.y = lerp(global_position.y, savedYPos, delta * 12)
		
	if !get_node(player).is_on_floor() && !get_node(player).hurt:
		resetYPos = true
		
		if resetYPos:
			savedYPos = get_node(player).global_position.y - 20
		
	shake_strength = lerp(shake_strength, 0 + climaxShake_strength, shakeDecayRate * delta) if !infiniteShaking else lerp(shake_strength, shake_strength, shakeDecayRate * delta)
	
	if GlobalVars.screenShake:
		offset = get_random_offset()

func _shake():
	shake_strength = randomShakeStr
	
func get_random_offset():
	return Vector2 (
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
