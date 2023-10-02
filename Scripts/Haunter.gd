extends Area2D

@export var speed : float = 1.0
@export var direction : Vector2

@onready var _animation_player : AnimationPlayer = $AnimationPlayer

func _on_player_moved():
	global_position += direction * speed
	_animation_player.play("haunt")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.kill()
