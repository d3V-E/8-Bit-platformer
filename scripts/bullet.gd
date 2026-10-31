extends Area2D


@onready var img: Sprite2D = $"bullet img"
@export var speed: float = 700.0
@export var damage = 1
var direction = 1

func _process(delta: float):
	position.x += speed * direction * delta

func left():
	direction = -1
	if img:
		img.rotation_degrees = 180



func right():
	direction = 1
	if img:
		img.rotation_degrees = 0


func _on_body_entered(body: Node2D):
	if body.has_method("recievedmg"):
		body.recievedmg(damage)
	
	queue_free()




func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
