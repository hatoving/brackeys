extends Node2D

export(NodePath) var scoreText = scoreText
export(NodePath) var timerText = timerText
export(NodePath) var fadeBG = fadeBG
export(NodePath) var cam = cam
export(NodePath) var door = door

var scaleDownScoreSize = false

var timer_temps = 0
var timer_s : float = 0
var timer_m : float = 2

var startedTimer = false

var nukeSfx = preload("res://audio/sfx/nuke.mp3")

func _ready():
	scoreText = get_node(scoreText)
	timerText = get_node(timerText)
	fadeBG = get_node(fadeBG)
	cam = get_node(cam)
	door = get_node(door)
	
	GlobalVars.climax = false
	MusManager._playSong("game")

func _process(delta):
	scoreText.text = str(GlobalVars.gameScore)
	
	if GlobalVars.climax && !startedTimer:
		timerText.show()
		door.show()
		startedTimer = true
	
	timerText.bbcode_text = "[right]" + str(timer_m) + ":" + (str(int(timer_s)) if timer_s > 9 else "0" + str(int(timer_s)))
	timerText.modulate = lerp(timerText.modulate, Color(1, 1, 1, 1), delta * 8)
	
	if timer_m < 1:
		cam.climaxShake_strength = 0.85
	if timer_s < 0:
			get_tree().change_scene("res://ShittyEnding.tscn")
			
	if timer_m == 0 && timer_s < 40:
		cam.climaxShake_strength = 1.25
		
	if timer_m == 0 && timer_s < 20:
		cam.climaxShake_strength = 1.35
	
	if startedTimer:
		if timer_temps <= 0:
			timer_temps = 1
			timer_s -= 1
			timerText.modulate = Color(1, 0, 0, 1)
			if timer_m == 0 && timer_s < 11:
				cam.shake_strength = 10
				$Voice.stream = nukeSfx
				$Voice.play()
		else:
			timer_temps -= delta
			
	if timer_m > 0 and timer_s < 0:
		timer_m -=1
		timer_s = 59
