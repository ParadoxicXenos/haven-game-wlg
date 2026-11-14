extends RigidBody2D

var slinging = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if slinging == true:
		visible = true
		$CollisionShape2D.disabled = false
	elif slinging == false:
		visible = false
		$CollisionShape2D.disabled = true

func _on_body_entered(body: Node) -> void:
	slinging = false
