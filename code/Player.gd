extends KinematicBody2D

var velocity = Vector2.ZERO

var speed = 115
var maxSpeed = 600

var fallSpeed = 600

var jumpHeight = 17500

var hurt = false
var ignoreFloor = false
var isOnFloor = false

var cantMove = false

var jumpSfx = preload("res://audio/sfx/player/Jump15.wav")
var hurtSfx = preload("res://audio/sfx/player/Hit_Hurt8.wav")

var yeahSfx = preload("res://audio/sfx/player/yeah.wav")
var ohnoSfx = preload("res://audio/sfx/player/ohno.wav")

var xScale = 1
var yScale = 1

var stars = preload("res://spawnableShit/Stars.tscn")

var screams = [
	preload("res://audio/sfx/player/hurt01.wav"),
	preload("res://audio/sfx/player/hurt02.wav"),
	preload("res://audio/sfx/player/hurt03.wav"),
	preload("res://audio/sfx/player/hurt04.wav"),
	preload("res://audio/sfx/player/hurt05.wav"),
	preload("res://audio/sfx/player/hurt06.wav"),
	preload("res://audio/sfx/player/hurt07.wav"),
	preload("res://audio/sfx/player/hurt08.wav"),
	preload("res://audio/sfx/player/hurt09.wav"),
	preload("res://audio/sfx/player/hurt10.wav")
]

export(NodePath) var cam

var level1Reached = false
var level2Reached = false
var level4Reached = false

onready var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	$AnimationPlayer.stop()
	
func _process(delta):
	if !GlobalVars.climax:
		if global_position.y < -1000 && global_position.y > -8500 &&!level2Reached:
			MusManager._playSong("gamemid")
			level2Reached = true
			level4Reached = false
			level1Reached = false
		if global_position.y < -8500 && !level4Reached:
			MusManager._playSong("game_high")
			level4Reached = true
			level2Reached = false
			level1Reached = false
		elif global_position.y > -1000 && !level1Reached:
			MusManager._playSong("game")
			level1Reached = true
			level4Reached = false
			level2Reached = false

func _physics_process(delta):
	isOnFloor = is_on_floor()
	
	$Sprite.global_scale.x = xScale 
	$Sprite.global_scale.y = yScale 
	
	xScale = lerp(xScale, 1, delta * 4)
	yScale = lerp(yScale, 1, delta * 4)
	
	#if Input.is_action_just_pressed("ui_end"):
		#global_position.y -= 1000
	
	if !hurt and !cantMove:
		if is_on_floor():
			if velocity.x != 0:
				$AnimationPlayer.play("run")
			else:
				$AnimationPlayer.play("idle")
			
		if velocity.x < 0:
			$Sprite.flip_h = true
		elif velocity.x > 0:
			$Sprite.flip_h = false
			
		if !is_on_floor():
			$AnimationPlayer.play("jump")
			
		if is_on_floor() && Input.is_action_just_pressed("ui_select"):
			velocity.y -= jumpHeight * delta
			
			xScale = 1.25
			yScale = 0.75
			
			$SFXStream.stream = jumpSfx
			$SFXStream.play()
	elif hurt:
		$AnimationPlayer.stop()
		
	if !cantMove:
		if Input.is_action_pressed("ui_right"):
			velocity.x = speed
			
			if hurt:
				rotation += 0.01
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -speed
			if hurt:
				rotation -= 0.01
		elif speed < (maxSpeed / 2):
			velocity.x = 0
			
		if velocity.y > 10:
			ignoreFloor = false
			
		if is_on_floor() && hurt && !ignoreFloor:
			hurt = false
			rotation = 0
	else:
		velocity.x = 0
		
	velocity.y += fallSpeed * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
func playHurtSfx():
	$SFXStream.stream = hurtSfx
	$SFXStream.play()
	
	$ScreamStream.stream = screams[rand.randf_range(0, len(screams))]
	$ScreamStream.play()
	
func playYeahSfx():
	$ScreamStream.stream = yeahSfx
	$ScreamStream.play()

func playScreamSfx():
	$ScreamStream.stream = ohnoSfx
	$ScreamStream.play()
	
func getHurt(damage, points):
	if is_on_floor():
		ignoreFloor = true
		
	velocity.y = 0
	
	hurt = true
	
	velocity.y -= damage
	velocity.x += 2 * speed
	
	$Sprite.frame = int(rand.randf_range(12, 27))
	
	get_node(cam)._shake()
	playHurtSfx()
	
	xScale = 1.45
	yScale = 0.45
	
	spawnStars()
	
	GlobalVars.gameScore += points
	GlobalVars.updateScoreSize()
	
func spawnStars():
	var starsInstance = stars.instance()
	
	self.add_child(starsInstance)
	starsInstance.global_position = Vector2(global_position.x, global_position.y - 20)
