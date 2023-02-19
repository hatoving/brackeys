extends Button

export(NodePath) var settingsMenu
export(NodePath) var mainMenu

func _on_Back_pressed():
	get_node(mainMenu).show()
	get_node(settingsMenu).hide()
