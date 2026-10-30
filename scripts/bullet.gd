extends Area2D

@export var speed: float = 700.0
@export var damage = 1


func _process(delta: float):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta




func _on_body_entered(body: Node2D):
	if body.has_method("recievedmg"):
		body.recievedmg(damage)
		
	queue_free()




func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
