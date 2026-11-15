extends Node2D
@export var nextLevel: PackedScene
@export var respawn : Vector2
func _on_finish_new_level() -> void:
	get_tree().change_scene_to_packed(nextLevel)
