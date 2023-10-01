extends Area2D

@export var speed : float = 1.0
@export var direction : Vector2

@onready var start_position = global_position
@onready var target_position = start_position + direction

func _on_player_moved():
	global_position = global_position.move_toward(target_position, speed)
	
	if global_position == target_position:
		var temp = start_position
		start_position = target_position
		target_position = temp

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
