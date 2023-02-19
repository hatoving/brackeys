extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "HTML5":
		queue_free()
		
func _process(delta):
	text = "Window Size (x" + str(GlobalVars.windowScale) + ")"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
