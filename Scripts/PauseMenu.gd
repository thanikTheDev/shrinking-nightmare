extends Control

@onready var main = $"../../"

func _on_resume_pressed():
	main.pause()

func _on_go_to_main_menu_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
