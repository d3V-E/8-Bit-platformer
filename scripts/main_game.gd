extends Node2D

@export var enemy: PackedScene
@onready var spawnarea = $Spawners.get_children()
@onready var hp1 = $CanvasLayer/Visual/Hp
@onready var hp2 = $CanvasLayer/Visual/Hp2
@onready var hp3 = $CanvasLayer/Visual/Hp3
@onready var alive = $CanvasLayer/Visual/alive
@onready var hit = $CanvasLayer/Visual/dmg
@onready var gameover = $CanvasLayer/gameover


var wave = 1
var health = 3
var spawned = 0
var maxspawn = 4

func _ready():
	gameover.visible = false
	alive.visible = true
	hit.visible = false
	hp1.visible = true
	hp2.visible = true
	hp3.visible = true
	$"CanvasLayer/wave header".text = "Wave " + str(wave)



func _on_timer_timeout():
	if spawned < maxspawn:
		if enemy == null:
			return
		var random = spawnarea.pick_random()
		var zombie = enemy.instantiate()
		spawned += 1
		zombie.global_position = random.global_position
		add_child(zombie)
	elif spawned >= maxspawn:
		waveupd()


func waveupd():
	await get_tree().create_timer(0.5).timeout
	wave += 1
	maxspawn = int(maxspawn * 1.5)
	spawned = 0
	$"CanvasLayer/wave header".text = "Wave" + str(wave)


func _on_lives_upd_timeout():
	var player = get_tree().get_first_node_in_group("Player")
	$CanvasLayer/Visual/info.text = "Get to surviving"
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
		gameover.visible = true
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/start.tscn")


func dmganim():
	alive.visible = false
	hit.visible = true
	$CanvasLayer/Visual/info.text = "Ow...."
	await get_tree().create_timer(0.2).timeout
	hit.visible = false
	alive.visible = true
