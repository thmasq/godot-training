extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if Input.is_action_pressed("ui_right"):
		velocity.x = 50
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -50
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -300
	velocity = move_and_slide(velocity)

func apply_gravity():
		velocity.y += 20
