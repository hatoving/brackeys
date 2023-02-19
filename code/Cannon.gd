extends Node2D

onready var ball = preload("res://spawnableShit/Ball.tscn")

export var minTimer : float = 2
export var maxTimer : float = 4

export var dir : float = 1

var timer = -1
var amountOfSecsToWait = 0

export var damage: float = 0

var shooting = false
var spedup = false

onready var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()
	$AnimationPlayer.get_animation("shoot").loop = false
	
func _startTimer():
	amountOfSecsToWait = rand_range(minTimer, maxTimer)
	timer = amountOfSecsToWait
	
func _spawnBall():
	var spawnedBall = ball.instance()
	
	get_parent().add_child(spawnedBall)
	
	spawnedBall.dir = dir
	spawnedBall.global_position = $SpawnPos.global_position
	
	if shooting: 
		$AnimationPlayer.play("shoot")
		shooting = false
	
func _process(delta):
	if amountOfSecsToWait == 0 or timer <= 0:
		_startTimer()
		_spawnBall()
		shooting = true
	else:
		#$AnimationPlayer.play("idle")
		timer -= delta
		
	if GlobalVars.climax && !spedup:
		minTimer - 1.25
		maxTimer - 2
		spedup = true

func _on_Hurtbox_body_entered(body):
	if body.get_name() == "Player":
		body.velocity.y = 0
	
		body.hurt = true
		
		print(self)
		
		body.velocity.y -= damage
		body.velocity.x += 2 * body.speed
		
		body.get_node("Sprite").frame = int(rand_range(12, 21))
		
		body.get_node(body.cam)._shake()
		body.playHurtSfx()
