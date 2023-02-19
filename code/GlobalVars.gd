extends Node

var gameScore = 0

var scaleDownScoreSize = false
var scoreSizeScale = 2

var windowScale = 1
var screenShake = true

var climax = false

func _process(delta):
	if get_tree().current_scene.name == "Game":
		var scoreText = get_tree().get_root().get_node("/root/Game/Camera2D/Control/ScoreText")
	
		if scaleDownScoreSize:
			scoreSizeScale -= delta * 4
		if scoreSizeScale <= 2:
			scoreSizeScale = 2
			scaleDownScoreSize = false
			
		scoreText.rect_scale.x = scoreSizeScale
		scoreText.rect_scale.y = scoreSizeScale

func updateScoreSize():
	scoreSizeScale = 4
	scaleDownScoreSize = true
