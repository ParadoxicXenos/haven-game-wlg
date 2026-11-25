extends Node2D

@export var parent : Node2D
var OGmousePos
@export var stickMult = 1000
const arrowMult = 0.5
@onready var arrowLine = $arrowLine
@onready var arrowHead = $arrowHead
@onready var playerPos = Vector2(0,0)
@export var charBody : CharacterBody2D
var controllerInput : Vector2
var backup_input: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arrowLine.visible = false
	arrowHead.visible = false
	controllerInput = Vector2(0,0)
	backup_input = Vector2(0,0)
	#arrowHead.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	playerPos = charBody.global_position

	if charBody.canSling:
		if Input.is_action_just_pressed("click"):
			OGmousePos = get_global_mouse_position()
			arrowLine.set_point_position(0,Vector2(0,0))

		elif Input.is_action_pressed("click") && Input.is_action_just_pressed("click") == false:
			charBody.canMove = false
			arrowLine.visible = true
			arrowHead.visible = true
			var mouseVec= OGmousePos-get_global_mouse_position()
			# If bigger than 1000 it needs to clamp
			if (mouseVec.length() > stickMult) :
				mouseVec = mouseVec.normalized() * stickMult
			arrowLine.set_point_position(1,Vector2(0,0)+mouseVec*arrowMult)
			arrowHead.position = Vector2(0,0) + mouseVec * arrowMult
			arrowHead.look_at(playerPos)
			arrowHead.rotation_degrees -= 90

		if Input.is_action_just_released("click"):
			print("release")
			var mouseVec= OGmousePos-get_global_mouse_position()
			# allow the player to cancel a sling by leaving the mouse where it started
			if ( round(abs(mouseVec.x)) > 40 || round(abs(mouseVec.y)) > 40) || charBody.slingCancels > 2:
				print("first_if_approved")
				charBody.slingCancels = 0
				charBody.slinging = true
				# If bigger than 1000 it needs to clamp
				if (mouseVec.length() > stickMult) :
					mouseVec = mouseVec.normalized() * stickMult
				if mouseVec != Vector2(0,0):
					arrowLine.visible = false
					arrowHead.visible = false
					charBody.arrowSpeed = mouseVec
					arrowHead.position = Vector2(0,0) + mouseVec * arrowMult
					arrowHead.global_rotation += arrowHead.get_angle_to(Vector2(0,0))
					charBody.canMove = true
					charBody.canSling = false
			else:
				print("else triggered")
				arrowLine.visible = false
				arrowHead.visible = false
				charBody.canMove = true
				charBody.slingCancels += 1
				print("cancels",charBody.slingCancels)
		
	if charBody.controller == true:
		print("time left: ", $"release timer2".time_left)
		if charBody.canSling == true:
			if Input.is_action_just_pressed("LT"):
				arrowLine.set_point_position(0,Vector2(0,0))

			if Input.is_action_pressed("LT"):
				Input.start_joy_vibration(0, 0.2, 0.3, 1.0)
				charBody.canMove = false
				arrowLine.visible = true
				arrowHead.visible = true
				
				var movementDiff = controllerInput.distance_to(Input.get_vector("Rright","Rleft","Rdown","Rup") * stickMult)
				#print("diff: ", movementDiff)
				if movementDiff > 400:
					backup_input = controllerInput
					$"release timer2".start(0.3)
					print("diff is big: ", movementDiff)
				controllerInput = Input.get_vector("Rright","Rleft","Rdown","Rup")
				controllerInput *= stickMult
				arrowLine.set_point_position(1,Vector2(0,0)+controllerInput*arrowMult)
				arrowHead.position = Vector2(0,0) + controllerInput * arrowMult
				arrowHead.look_at(playerPos)
				arrowHead.rotation_degrees -= 90

			if Input.is_action_just_released("LT"):
				if $"release timer2".time_left > 0.0:
					controllerInput = backup_input
					backup_input = Vector2(0,0)
				if controllerInput != Vector2(0,0):
					charBody.slinging = true
					arrowLine.visible = false
					arrowHead.visible = false
					charBody.arrowSpeed = controllerInput
					arrowHead.position = Vector2(0,0) + controllerInput * arrowMult
					arrowHead.global_rotation += arrowHead.get_angle_to(Vector2(0,0))
					controllerInput = Vector2(0,0)
					backup_input = Vector2(0,0)
					charBody.canMove = true
					charBody.canSling = false
				else :
					controllerInput = Vector2(0,0)
					backup_input = Vector2(0,0)
					charBody.canMove = true
					arrowLine.visible = false
					arrowHead.visible = false
