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
	print("Running: ", Engine.get_frames_per_second())
	$Camera2D/Label.text = "FPS: %d" % Engine.get_frames_per_second()

	for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is RigidBody2D:
				velocity= Vector2(0,0)
				slinging= false
				global_position = $"../..".respawn
				
	# top and bottom death bounds
	if position.y > 2300:
		velocity = Vector2(0,0)
		global_position = $"../..".respawn
	if position.y < -2500:
		velocity = Vector2(0,0)
		global_position = $"../..".respawn
		
	# sling animation and hitbox logic
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
		
	print("slinging",slinging)
	#gravity
	if not is_on_floor():
		velocity += Vector2(0, GRAVITY) * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor() || Input.is_action_just_pressed("Lup") and is_on_floor() || Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if !slinging:
		$AnimatedSprite2D.rotation=0
		$CollisionShape2D.shape.height = 178.0
		$CollisionShape2D.shape.radius = 67.0
		if controller == true:
			direction = Input.get_axis("Lleft", "Lright")
		elif controller == false:
			direction = Input.get_axis("left", "right") 
		
		if direction:
			$AnimatedSprite2D.play("Walk")
			velocity.x += direction * SPEED
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			elif direction > 0:
				$AnimatedSprite2D.flip_h = false
		velocity.x *= 0.9

	if is_on_floor() :
		canSling = true
		
	# end sling 0.5 seconds after last collisiom
	if slinging && $Timer.time_left == 0.0:
		slinging = false
		$AnimatedSprite2D.play("Idle")

	# transfer the arrows potential speed to the player
	if arrowSpeed != Vector2(0,0) && $Timer.time_left > 0:
		velocity.x = arrowSpeed.x * FLYMULT
		velocity.y = arrowSpeed.y * FLYMULT
	arrowSpeed = Vector2(0,0)
	var velo = velocity
	
	if canMove:
		move_and_slide()
	else :
		velocity = Vector2(0, 0)
		
	if !slinging :
		$Timer.start()
		
	if slinging :
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is StaticBody2D:
				Input.start_joy_vibration(0, 1, 1, 0.2)
				collision_normal = collision.get_normal()
				collision_point = collision.get_position()
				impact = (velo.x * collision_normal.x)+(velo.y*collision_normal.y)
				reflected = Vector2(velo.x-(1.8*impact*collision_normal.x),velo.y-(1.8*impact*collision_normal.y))
				velocity=reflected
				reflected = Vector2(0,0)
				print(velocity)
				if velocity.y > -105 && velocity.y < 0:
					velocity.y = 0
				# on a bounce reset the sling end timer
				$Timer.start()
			if collider is RigidBody2D:
				global_position = $"../..".respawn
				
	# send player vel to the motion blur shader
	RenderingServer.global_shader_parameter_set("player_move_dir", velocity)
