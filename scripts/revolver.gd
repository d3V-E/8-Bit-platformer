extends AnimatedSprite2D

@export var bullet : PackedScene
@onready var barell: Node2D = $bullet

func shoot():
	if not bullet:
		return
	play("default")
	var rounds = bullet.instantiate()
	if flip_h == true:
		rounds.left()
	else:
		rounds.right()
	rounds.global_position = barell.global_position
	rounds.rotation = global_rotation
	get_tree().current_scene.add_child(rounds)
