extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float

signal moved()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("left", "right")
	if direction:
		emit_signal("moved")
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()

func game_over():
	get_tree().reload_current_scene()
