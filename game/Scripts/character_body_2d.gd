extends CharacterBody2D


const SPEED = 160.0
const GRAVITY = 2000.0
const JUMP_VELOCITY = -1000.0
var xSpeed = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector2(0, GRAVITY) * delta
	print(delta)
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		xSpeed += direction * SPEED
	xSpeed *= 0.9
	velocity.x = move_toward(xSpeed, 0, SPEED)

	move_and_slide()
