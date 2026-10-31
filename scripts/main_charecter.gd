extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var gun : AnimatedSprite2D = $revolver
@onready var animsprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		animsprite.flip_h = false
		gun.position.x = 8
		gun.flip_h = false
	elif direction < 0:
		animsprite.flip_h = true
		gun.position.x = -8
		gun.flip_h = true
		
	
	if direction == 0:
		animsprite.play("idle")
	else:
		animsprite.play("run")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("Shoot"):
		gun.shoot()
