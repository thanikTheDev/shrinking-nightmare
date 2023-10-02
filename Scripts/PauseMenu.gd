extends Control

@onready var main = $"../../"

func _on_resume_pressed():
	main.pause()

func _on_go_to_main_menu_pressed():
	main.pause()
	get_node("/root/GameData").reset_deaths()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_exit_pressed():
	get_tree().quit()
