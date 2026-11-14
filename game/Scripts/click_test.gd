extends Node2D
var OGmousePos


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		OGmousePos = get_global_mouse_position()
		print(OGmousePos)
	elif Input.is_action_pressed("click") && Input.is_action_just_pressed("click") == false:
		var mouseVec= OGmousePos-get_global_mouse_position()
		print(mouseVec)
		$Sprite2D.position = OGmousePos + mouseVec
	if Input.is_action_just_released("click"):
		var mouseVec= OGmousePos-get_global_mouse_position()
		print(mouseVec,"RELEASED")
		$Sprite2D.position = OGmousePos + mouseVec
		
