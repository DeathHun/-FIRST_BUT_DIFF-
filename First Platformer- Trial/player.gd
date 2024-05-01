extends CharacterBody2D

const SPEED = 110.0
const ACCELERATION = 400.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -280

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2.0:
			velocity.y = JUMP_VELOCITY / 2.0

	# Get the input direction and handle the movement/deceleration.
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED*input_axis, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
