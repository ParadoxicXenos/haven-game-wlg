extends Node2D
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += sin(time * 0.98) * 0.2
	position.y += sin(time * 1.12) * 0.2
	rotation = 0.02 - sin(time) * 0.04
	time += 0.03
