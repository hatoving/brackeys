extends Button

func _on_Change_pressed():
	match(GlobalVars.windowScale):
		1:
			GlobalVars.windowScale += 1
			OS.set_window_size(Vector2(736 * 2, 480 * 2))
			
		2:
			GlobalVars.windowScale = 1
			OS.set_window_size(Vector2(736, 480))
