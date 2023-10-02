extends Area2D

signal collected

@onready var _animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
	_animation_player.play("idle")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("collected")
		_animation_player.play("collected")
