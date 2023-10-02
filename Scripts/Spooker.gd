extends Area2D

@export var speed : float = 1.0
@export var direction : Vector2

@onready var _animation_player : AnimationPlayer = $AnimationPlayer
@onready var _start_position = global_position
@onready var _target_position = _start_position + direction

func _on_player_moved():
	global_position = global_position.move_toward(_target_position, speed)
	_animation_player.play("spook")
	
	if global_position == _target_position:
		var temp = _start_position
		_start_position = _target_position
		_target_position = temp

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.kill()
