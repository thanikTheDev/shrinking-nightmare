extends Area2D

@export_file("*.tscn") var next_level
@export var key : Node2D

var locked : bool = false

func _ready():
	assert(next_level)
	
	if key:
		locked = true
		key.collected.connect(_on_key_collected)

func _on_body_entered(body):
	if body.is_in_group("Player") and not locked:
		get_tree().change_scene_to_file(next_level)

func _on_key_collected():
	locked = false
