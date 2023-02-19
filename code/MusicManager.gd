extends AudioStreamPlayer

onready var dummy = AudioStreamPlayer.new()
var fading = false
var fadingOut = false

func _ready():
	add_child(dummy)
	
func _process(delta):
	if fading:
		volume_db -= 45 * delta
		dummy.volume_db += 45 * delta
		
		if dummy.volume_db >= -10:
			volume_db = -10
			dummy.volume_db = -60
			
			stream = dummy.stream
			play(dummy.get_playback_position())
			
			dummy.stop()
			fading = false
			
	if fadingOut:
		volume_db -= 45 * delta
		dummy.volume_db -= 45 * delta
		
		if volume_db <= -60:
			volume_db = -60
			dummy.volume_db = -60
			fadingOut = false
			
func _playSongNoFade(song_name):
	stream = load("res://audio/mus/" + song_name + ".mp3")
	play()

func _playSong(song_name):
	dummy.stream = load("res://audio/mus/" + song_name + ".mp3")
	dummy.volume_db = -60
	dummy.play()
	
	fading = true
	
func _resetAndPlaySong(song_name, volume):
	stream = load("res://audio/mus/" + song_name + ".mp3")
	
	volume_db = volume
	dummy.volume_db = -60
	
	play()
	
func _fadeOut():
	fadingOut = true

func _stopEverything():
	stop()
	dummy.stop()
