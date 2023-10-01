extends CharacterBody2D

signal moved()

const JUMP_VELOCITY = -400.0
const SPEED = 150.0

@onready var collider : CollisionShape2D = $Collider
var crouched : bool = false
var direction : float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var previous_position : Vector2 = global_position
	var current_speed = SPEED
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_pressed("crouch") and not crouched:
			crouched = true
			current_speed *= 0.5
			collider.shape.height = 15
			collider.position.y = 8
		elif crouched:
			current_speed *= 0.5
			if not Input.is_action_pressed("crouch") and not is_under_object():
				crouched = false
		else:
			crouched = false
			collider.shape.height = 31
			collider.position.y = 0
			

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = 0

	move_and_slide()
	
	if previous_position != global_position:
		emit_signal("moved")

func game_over():
	get_tree().reload_current_scene()

func is_under_object():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2.UP)
	query.exclude = [self]
	return space_state.intersect_ray(query)


func _on_moved():
	pass # Replace with function body.


func _on_haunter_body_entered(body):
	pass # Replace with function body.


func _on_chaser_body_entered(body):
	pass # Replace with function body.
