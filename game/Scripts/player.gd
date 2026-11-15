extends CharacterBody2D
##CHARACTER BODY IS 0, and rigidbody =1

var canSling = true
var canMove = true
const SPEED = 160.0
const GRAVITY = 2000.0
const FLYMULT = 3.0
const JUMP_VELOCITY = -1000.0
var xSpeed = 0
var arrowSpeed : Vector2
var slinging = false
var reflected = Vector2(0,0)
var collision_normal:Vector2
var collision_point:Vector2
var impact
var controller = false
var direction: float
func _ready():
	if Input.get_connected_joypads().size() > 0:
		controller = true
	print("controller:",controller)
func _physics_process(delta: float) -> void:
	if slinging == true:
		$CollisionShape2D.shape.height = 70.0
		$CollisionShape2D.shape.radius = 70.0
		$AnimatedSprite2D.play("Roll")
		if velocity.x < 0:
			$AnimatedSprite2D.rotation +=1
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.rotation -=1
			$AnimatedSprite2D.flip_h = false
	else : $AnimatedSprite2D.play("Walk")
		
	print("slinging",slinging)
	if not is_on_floor():
		velocity += Vector2(0, GRAVITY) * delta
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor() || Input.is_action_just_pressed("Lup") and is_on_floor() || Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.

	if !slinging:
		$AnimatedSprite2D.rotation=0
		$CollisionShape2D.shape.height = 178.0
		$CollisionShape2D.shape.radius = 67.0
		if controller == true:
			direction = Input.get_axis("Lleft", "Lright")
		elif controller == false:
			direction = Input.get_axis("left", "right") 
		if direction:
			velocity.x += direction * SPEED
			$AnimatedSprite2D.play("Walk")
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			elif direction > 0:
				$AnimatedSprite2D.flip_h = false
		velocity.x *= 0.9

	if is_on_floor() :
		canSling = true
		
	if slinging && $Timer.time_left == 0.0:
		slinging = false

	if arrowSpeed != Vector2(0,0) && $Timer.time_left > 0:
		velocity.x = arrowSpeed.x * FLYMULT
		velocity.y = arrowSpeed.y * FLYMULT
	arrowSpeed = Vector2(0,0)
	var velo=velocity
	
	if canMove:
		move_and_slide()
	else :
		velocity = Vector2(0, 0)
		
	if ! slinging :
		$Timer.start()
	if slinging :
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is StaticBody2D:
				collision_normal = collision.get_normal()
				collision_point = collision.get_position()
				impact = (velo.x * collision_normal.x)+(velo.y*collision_normal.y)
				reflected = Vector2(velo.x-(1.8*impact*collision_normal.x),velo.y-(1.8*impact*collision_normal.y))
				velocity=reflected
				reflected = Vector2(0,0)
				print(velocity)
				if velocity.y > -105 && velocity.y < 0:
					velocity.y = 0
				$Timer.start()
				
	print($Timer.time_left)
	RenderingServer.global_shader_parameter_set("player_move_dir", velocity)
