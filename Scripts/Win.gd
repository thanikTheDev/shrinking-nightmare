extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Control/CenterContainer/VBoxContainer/DeathCount.text = "Congradulations!\nTotal Death Count: " + str(get_node("/root/GameData").number_of_deaths).pad_zeros(2)


func _on_to_main_menu_pressed():
	get_node("/root/GameData").reset_deaths()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
