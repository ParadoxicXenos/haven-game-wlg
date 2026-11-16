extends Node2D

@export var parent : Node2D
var OGmousePos
@export var stickSpeed = 1000
const arrowMult = 0.5
@onready var arrowLine = $arrowLine
@onready var arrowHead = $arrowHead
@onready var playerPos = Vector2(0,0)
@export var charBody : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arrowLine.visible = false
	arrowHead.visible = false
	#arrowHead.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("controller",charBody.controller)
	if 1==1:
		playerPos = charBody.global_position

		if charBody.canSling:
			if Input.is_action_just_pressed("click"):
				OGmousePos = get_global_mouse_position()
				print(OGmousePos)
				arrowLine.set_point_position(0,Vector2(0,0))
				
				
			elif Input.is_action_pressed("click") && Input.is_action_just_pressed("click") == false:
				charBody.canMove = false
				arrowLine.visible = true
				arrowHead.visible = true
				var mouseVec= OGmousePos-get_global_mouse_position()
				# If bigger than 1000 it needs to clamp
				if (mouseVec.length() > stickSpeed) :
					mouseVec = mouseVec.normalized() * stickSpeed
				arrowLine.set_point_position(1,Vector2(0,0)+mouseVec*arrowMult)
				arrowHead.position = Vector2(0,0) + mouseVec * arrowMult
				arrowHead.look_at(playerPos)
				arrowHead.rotation_degrees -= 90

			if Input.is_action_just_released("click"):
				charBody.slinging = true
				var mouseVec= OGmousePos-get_global_mouse_position()
				# If bigger than 1000 it needs to clamp
				if (mouseVec.length() > stickSpeed) :
					mouseVec = mouseVec.normalized() * stickSpeed
				print("RELEASED")
				arrowLine.visible = false
				arrowHead.visible = false
				charBody.arrowSpeed = mouseVec
				print("mousevec:",mouseVec)
				print("velocity:",charBody.velocity)
				arrowHead.position = Vector2(0,0) + mouseVec * arrowMult
				arrowHead.global_rotation += arrowHead.get_angle_to(Vector2(0,0))
				charBody.canMove = true
				charBody.canSling = false
		
	if charBody.controller == true:
			if charBody.canSling == true:
				if Input.is_action_just_pressed("LT"):
					print("LT")
					arrowLine.set_point_position(0,Vector2(0,0))

				if Input.is_action_pressed("LT"):
					Input.start_joy_vibration(0, 0.5, 0.8, 1.0)
					charBody.canMove = false
					arrowLine.visible = true
					arrowHead.visible = true
					var controllerInput = Input.get_vector("Rleft","Rright","Rup","Rdown")
					controllerInput *= stickSpeed
					print("VEC",controllerInput)
					arrowLine.set_point_position(1,Vector2(0,0)+controllerInput*arrowMult)
					arrowHead.position = Vector2(0,0) + controllerInput * arrowMult
					arrowHead.look_at(playerPos)
					arrowHead.rotation_degrees -= 90

				if Input.is_action_just_released("LT"):
					charBody.slinging = true
					var controllerInput = Input.get_vector("Rleft","Rright","Rup","Rdown")
					controllerInput *= stickSpeed
					print("RELEASED")
					arrowLine.visible = false
					arrowHead.visible = false
					charBody.arrowSpeed = controllerInput
					print("controller input:",controllerInput)
					print("velocity:",charBody.velocity)
					arrowHead.position = Vector2(0,0) + controllerInput * arrowMult
					arrowHead.global_rotation += arrowHead.get_angle_to(Vector2(0,0))
					charBody.canMove = true
					charBody.canSling = false
