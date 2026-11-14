extends Node2D
@export var hwr : Vector3
@onready var shape = $StaticBody2D/CollisionShape2D.shape
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape.size = Vector2(hwr.x,hwr.y)
	rotation = hwr.z
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
