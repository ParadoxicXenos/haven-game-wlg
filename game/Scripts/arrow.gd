extends Node2D
@export var parent : Node2D
var OGmousePos
const arrowMult = 0.5
@onready var arrowLine = $arrowLine
@export var charBody : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		OGmousePos = get_global_mouse_position()
		print(OGmousePos)
		arrowLine.set_point_position(0,Vector2(0,0))
		
	elif Input.is_action_pressed("click") && Input.is_action_just_pressed("click") == false:
		arrowLine.visible = true
		var mouseVec= OGmousePos-get_global_mouse_position()
		arrowLine.set_point_position(1,Vector2(0,0)+mouseVec*arrowMult)
		##$Sprite2D.position = OGmousePos + mouseVec
	if Input.is_action_just_released("click"):
		var mouseVec= OGmousePos-get_global_mouse_position()
		print("RELEASED")
		arrowLine.visible = false
		charBody.arrowSpeed = mouseVec
		print("mousevec:",mouseVec)
		print("velocity:",charBody.velocity)
