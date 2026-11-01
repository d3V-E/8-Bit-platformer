extends CharacterBody2D


@export var speed: float = 50
@export var hp:int = 2
@onready var sprite = $zombie



func _physics_process(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	var player = get_parent().get_node_or_null("Player")
	if player.global_position.x > global_position.x:
		velocity.x = speed
		sprite.flip_h = true
	else:
		velocity.x = -speed
		sprite.flip_h = false
	var distance = global_position.distance_to(player.global_position)
	if distance < 16:
		player.takedmg()
		print("y")
	move_and_slide()

func rdmg(amnt):
	hp -= amnt
	if hp <= 0:
		clearscene()


func clearscene():
	queue_free()






#func _on_box_body_entered(body: Node2D):
	#var playert = get_tree().get_first_node_in_group("Player")
	#if body.get("identif"):
		#body.taked()
		#print("y")
