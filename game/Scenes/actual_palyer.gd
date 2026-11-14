extends Node2D

@export var characterbod: CharacterBody2D
@export var regidbod: RigidBody2D

var player_node: Node2D
func _on_ready():
	player_node = characterbod
func _input(event):
	
	if Input.is_action_just_pressed("space"):
		player_node.process_mode == Node.PROCESS_MODE_DISABLED
		player_node.hide()

		player_node = regidbod if player_node == characterbod else characterbod

		player_node.show()
		player_node.process_mode = Node.PROCESS_MODE_INHERIT
