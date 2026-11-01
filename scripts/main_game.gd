extends Node2D

@export var enemy: PackedScene
@onready var spawnarea = $Spawners.get_children()


func _ready():
	pass





func _on_timer_timeout():
	if enemy == null:
		return
	var random = spawnarea.pick_random()
	var zombie = enemy.instantiate()
	zombie.global_position = random.global_position
	add_child(zombie)
