extends Node2D

@export var parent : Node2D
var OGmousePos
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
	if charBody.slinging:
		charBody.canMove = false
		
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
			arrowLine.set_point_position(1,Vector2(0,0)+mouseVec*arrowMult)
			arrowHead.position = Vector2(0,0) + mouseVec * arrowMult
			arrowHead.look_at(playerPos)
			arrowHead.rotation_degrees -= 90

		if Input.is_action_just_released("click"):
			charBody.slinging = false
			var mouseVec= OGmousePos-get_global_mouse_position()
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
