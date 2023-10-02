extends Node2D

@onready var _ui = $CanvasLayer/UI
@onready var _pause_menu = $"CanvasLayer/Pause Menu"

var _paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause()
		
func pause():
	if _paused:
		$Player.set_physics_process(true)
		_pause_menu.hide()
		_ui.show()
		Engine.time_scale = 1
	else:
		$Player.set_physics_process(false)
		_pause_menu.show()
		_ui.hide()
		Engine.time_scale = 0
	
	_paused = not _paused
