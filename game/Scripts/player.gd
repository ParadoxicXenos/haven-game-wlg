extends CharacterBody2D
##CHARACTER BODY IS 0, and rigidbody =1
var canSling = true
var canMove = true
const SPEED = 160.0
const GRAVITY = 2000.0
const FLYMULT = 4.0
const JUMP_VELOCITY = -1000.0
var xSpeed = 0
var arrowSpeed : Vector2
var slinging = false
var reflected = Vector2(0,0)
var collision_normal:Vector2
var collision_point:Vector2
var impact
func _on_ready():
	pass
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector2(0, GRAVITY) * delta
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.

	if !slinging:
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x += direction * SPEED
		velocity.x *= 0.9
	if is_on_floor():
		canSling=true
		slinging = false

	if arrowSpeed != Vector2(0,0):
		velocity.x = arrowSpeed.x * FLYMULT
		velocity.y = arrowSpeed.y * FLYMULT
	arrowSpeed = Vector2(0,0)
	var velo=velocity
		
	if canMove:
		move_and_slide()
<<<<<<< Updated upstream
=======
		
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is StaticBody2D:
			collision_normal = collision.get_normal()
			collision_point = collision.get_position()
			print("normal",collision_normal)
			print("point",collision_point)
			impact = (velo.x * collision_normal.x)+(velo.y*collision_normal.y)
			reflected = Vector2(velo.x-(1.8*impact*collision_normal.x),velo.y-(1.8*impact*collision_normal.y))
			velocity=reflected
			reflected = Vector2(0,0)
	
>>>>>>> Stashed changes
