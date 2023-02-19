extends AudioStreamPlayer

export(NodePath) var gameLoop

var playedSfx = false
var phase = 0

var hurryUp = preload("res://audio/sfx/hurry up.wav")
var time = preload("res://audio/sfx/time.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	gameLoop = get_node(gameLoop)
	
func _process(delta):
	if GlobalVars.climax && !playedSfx && phase == 0:
		stream = hurryUp
		play()
		playedSfx = true
		phase += 1
		
	if !playing && playedSfx:
		playedSfx = false
		
	if phase == 1 && gameLoop.timer_m < 1 && !playedSfx:
		stream = time
		play()
		playedSfx = true
		phase += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
