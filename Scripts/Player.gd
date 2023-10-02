extends CharacterBody2D

signal moved()

const JUMP_VELOCITY = -600.0
const LOW_JUMP_MULTIPLIER = 3
const FALL_MULTIPLIER = 1.2
const SPEED = 150.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var collider : CollisionShape2D = $Collider
@onready var sprite : Sprite2D = $Sprite

var collider_height: int = 127
var crouched : bool = false
var current_speed : float
var direction : float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	set_physics_process(false)

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		kill()

func _physics_process(delta):
	var previous_position : Vector2 = global_position
	current_speed = SPEED
	
	if not is_on_floor():
		_update_vertical_velocity(delta)
	else:
		_update_grounded_logic()
		
	_update_horizontal_velocity()
	
	move_and_slide()
	_update_animation_parameters()
	
	if previous_position != global_position:
		emit_signal("moved")

func _update_vertical_velocity(delta):
	if velocity.y > 0:
		if not Input.is_action_pressed("jump"):
			velocity.y += gravity * LOW_JUMP_MULTIPLIER * delta
		else:
			velocity.y += gravity * delta
	else:		
		velocity.y += gravity * FALL_MULTIPLIER * delta 

func _update_horizontal_velocity():
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = 0

func _update_grounded_logic():
	if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("crouch") and not crouched:
		crouched = true
		current_speed *= 0.5
		collider.shape.height = (collider_height + 1) / 2 - 1
		collider.position.y = (collider_height + 1) / 4
	elif crouched:
		current_speed *= 0.5
		if not Input.is_action_pressed("crouch") and not _is_under_object():
			crouched = false
	else:
		crouched = false
		collider.shape.height = collider_height
		collider.position.y = 0 

func _update_animation_parameters():
	animation_tree["parameters/conditions/idling"] = velocity == Vector2.ZERO
	animation_tree["parameters/conditions/walking"] = velocity.x != 0 and velocity.y == 0
	animation_tree["parameters/conditions/crouching"] = crouched
	animation_tree["parameters/conditions/standing"] = not crouched
	animation_tree["parameters/conditions/jumping"] = not is_on_floor() and velocity.y < 0
	animation_tree["parameters/conditions/falling"] = not is_on_floor() and velocity.y > 0
	
	if direction:
		sprite.set("flip_h", direction < 0)

func _is_under_object():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2.UP)
	query.exclude = [self]
	return space_state.intersect_ray(query)

func _game_over():
	get_tree().reload_current_scene()

func kill():
	animation_tree.active = false
	animation_player.play("death")
