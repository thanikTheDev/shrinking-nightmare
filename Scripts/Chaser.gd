extends Area2D

@export var speed : float = 1.0

@onready var player : Node2D = get_node("/root/Main/Player")

func _on_player_moved():
	global_position = global_position.move_toward(player.position, speed)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
