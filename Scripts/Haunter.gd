extends Area2D

@export var speed : float = 1.0
@export var direction : Vector2

func _on_player_moved():
	global_position += direction * speed

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
