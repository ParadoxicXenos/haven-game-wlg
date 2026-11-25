extends CharacterBody2D

##CHARACTER BODY IS 0, and rigidbody =1

var canSling = true
var canMove = true
const SPEED = 160.0
const GRAVITY = 2000.0
const JUMP_VELOCITY = -1000.0
var slinging = false
var direction: float
var arrowSpeed = Vector2(0,0)
const FLYMULT = 3.0

func jump():
	velocity.y = JUMP_VELOCITY
	
func sling(input: Vector2):
	arrowSpeed = Vector2(input)
func _ready():
	while true :
		$Timer.start(randf_range(1, 6))
		await $Timer.timeout
		jump()
	
	await $Timer.timeout
	sling(Vector2(10,-10))
	
func _physics_process(delta: float) -> void:
	if arrowSpeed != Vector2(0,0):
		velocity.x = arrowSpeed.x * FLYMULT
		velocity.y = arrowSpeed.y * FLYMULT
		arrowSpeed = Vector2(0,0)
	
	if slinging == true:
		$CollisionShape2D.shape.height = 70.0
		$CollisionShape2D.shape.radius = 70.0
		$AnimatedSprite2D.play("Roll")
		# spin direction
		if velocity.x < 0:
			$AnimatedSprite2D.rotation -=1
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.rotation +=1
			$AnimatedSprite2D.flip_h = false
	elif abs(velocity.x) < 90: $AnimatedSprite2D.play("Idle")
		
	if not is_on_floor():
		velocity += Vector2(0, GRAVITY) * delta

	# Get the input direction and handle the movement/deceleration.

	if !slinging:
		$AnimatedSprite2D.rotation=0
		$CollisionShape2D.shape.height = 178.0
		$CollisionShape2D.shape.radius = 67.0
		
		if direction:
			$AnimatedSprite2D.play("Walk")
			velocity.x += direction * SPEED
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			elif direction > 0:
				$AnimatedSprite2D.flip_h = false
		velocity.x *= 0.9

		move_and_slide()
	else :
		velocity = Vector2(0, 0)
