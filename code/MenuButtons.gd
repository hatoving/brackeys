extends Node2D

export(NodePath) var settingsMenu
export(NodePath) var mainMenu

func _ready():
	get_node(settingsMenu).set_process(false)
	MusManager._playSongNoFade("menu")

func _on_Play_pressed():
	get_tree().change_scene("res://Env.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Settings_pressed():
	get_node(mainMenu).hide()
	get_node(settingsMenu).show()
