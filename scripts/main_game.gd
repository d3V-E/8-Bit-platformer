extends Node2D

@export var enemy: PackedScene
@onready var spawnarea = $Spawners.get_children()
@onready var hp1 = $CanvasLayer/Visual/Hp
@onready var hp2 = $CanvasLayer/Visual/Hp2
@onready var hp3 = $CanvasLayer/Visual/Hp3
@onready var alive = $CanvasLayer/Visual/alive
@onready var hit = $CanvasLayer/Visual/dmg




var health = 3


func _ready():
	alive.visible = true
	hit.visible = false
	hp1.visible = true
	hp2.visible = true
	hp3.visible = true



func _on_timer_timeout():
	if enemy == null:
		return
	var random = spawnarea.pick_random()
	var zombie = enemy.instantiate()
	zombie.global_position = random.global_position
	add_child(zombie)




func _on_lives_upd_timeout():
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return
	health = player.lives
	if health >= 3:
		hp1.visible = true
		hp2.visible = true
		hp3.visible = true
	elif health == 2:
		hp1.visible = true
		hp2.visible = true
		hp3.visible = false
	elif health == 1:
		hp1.visible = true
		hp2.visible = false
		hp3.visible = false
	elif health <= 0:
		hp1.visible = false
		hp2.visible = false
		hp3.visible = false



func dmganim():
	alive.visible = false
	hit.visible = true
	await get_tree().create_timer(0.5).timeout
	hit.visible = false
	alive.visible = true
