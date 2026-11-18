extends Node2D
@export var stickSpeed = 1000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$leftlabel.text = str("left stick:",Input.get_vector("Lleft","Lright","Lup","Ldown")*stickSpeed)
	$rightlabel.text = str("right stick",Input.get_vector("Rright","Rleft","Rdown","Rup")*stickSpeed)
