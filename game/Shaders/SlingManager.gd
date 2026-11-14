extends Node2D

@export var player : RemoteTransform2D
@export var sling : RemoteTransform2D

var characterBodySelected = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("down") :
		characterBodySelected = !characterBodySelected
		
		if characterBodySelected :
			# go to rigid
			
			# swap art & cam pos
			$Player/playerTransform.update_position = false
			$PlayerRigidMovement/slingTransform.update_position = true
			
			# swap positions of objects
			$PlayerRigidMovement.global_position = $Player.global_position
			$PlayerRigidMovement.linear_velocity = $Player.velocity
			
			# resume the rigidbody2d
			$PlayerRigidMovement.freeze = false
			
			# disable the other collision shape
			$Player/CollisionShape2D.set_deferred("disabled", true)
			$PlayerRigidMovement/CollisionShape2D.set_deferred("disabled", false)

		else :
			# go to char
			
			# swap art & cam pos
			$Player/playerTransform.update_position = true
			$PlayerRigidMovement/slingTransform.update_position = false
			
			# swap positions of objects
			$Player.global_position = $PlayerRigidMovement.global_position
			$Player.velocity = $PlayerRigidMovement.linear_velocity
			
			# stop the rigidbody2d
			$PlayerRigidMovement.freeze = true
			
			# disable the other collision shape
			$Player/CollisionShape2D.set_deferred("disabled", false)
			$PlayerRigidMovement/CollisionShape2D.set_deferred("disabled", true)
			
			
