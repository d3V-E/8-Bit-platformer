extends AnimatedSprite2D

@export var bullet : PackedScene
@onready var barell: Node2D = $bullet

func shoot():
	if not bullet:
		return
	play("default")
	var rounds = bullet.instantiate()
	rounds.global_position = barell.global_position
	rounds.rotation = global_rotation
	get_tree().current_scene.add_child(rounds)
