extends Area2D

@export_file("*.tscn") var next_level
@export var key : Node2D

@onready var _sprite : Sprite2D = $Sprite 

var _locked : bool = false

func _ready():
	assert(next_level)
	
	if key:
		_locked = true
		_sprite.frame = 1
		key.collected.connect(_on_key_collected)

func _on_body_entered(body):
	if body.is_in_group("Player") and not _locked:
		get_tree().change_scene_to_file(next_level)

func _on_key_collected():
	_locked = false
	_sprite.frame = 0
