

extends Area2D

@export_file("Test Level 2.tscn") var next_scene

# when the player hits the goal, load the next level.
# Called when the node enters the scene tree for the first time.
#get.tree().change_scene("res://Scenes/Test Level 2.tscn")

func _on_body_entered(body):
  if body.is_in_group("Player"): get_tree().change_scene_to_file(next_scene)
