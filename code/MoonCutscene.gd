extends Area2D

var start = false

export(NodePath) var player
export(NodePath) var playerSprite
export(NodePath) var playerAnimator
export(NodePath) var cam

var done = false
var playedSfx = false

var timer = 0
var phase = 0

func _ready():
	player = get_node(player)
	playerSprite = get_node(playerSprite)
	playerAnimator = get_node(playerAnimator)
	cam = get_node(cam)
	
func _process(delta):
	if start && !done:
		player.cantMove = true
		player.hurt = false
		
		player.rotation = 0
		player.velocity.y = 0
		
		player.global_position.x = lerp(player.global_position.x, 185, delta * 12)
		player.global_position.y = lerp(player.global_position.y, -14608, delta * 12)
		
		timer += delta
		
		if timer >= 4 and phase == 0:
			phase += 1
		elif timer >= 6.5 and phase == 1:
			phase += 1
		elif timer >= 9 and phase == 2:
			phase = 3
		elif timer >= 12 and phase == 3:
			phase = 4
		
		match (phase):
			0:
				MusManager._fadeOut()
				playerSprite.frame = 27
			1:
				playerSprite.frame = 28
				if !playedSfx:
					player.playYeahSfx()
					playedSfx = true
			2:
				playerSprite.frame = 27
				playedSfx = false
			3:
				if !cam.infiniteShaking:
					cam.infiniteShaking = true
					cam.shake_strength = 0.75
					
				if !playedSfx:
					player.playScreamSfx()
					playedSfx = true
					
				playerAnimator.play("ohfuck")
				
				playerSprite.flip_h = false
			4:
				cam.infiniteShaking = false
				cam.climaxShake_strength = 0.5
				GlobalVars.climax = true
				player.cantMove = false
				done = true
				MusManager._resetAndPlaySong("endseq", -4)
				phase += 1

func _on_MoonCutscene_body_entered(body):
	if body.name == "Player":
		start = true
