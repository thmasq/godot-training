class_name Wizard
extends KinematicBody2D
var velocity = Vector2.ZERO
var fast_fell = false
var hit_possible = false
export(int) var JUMP_FORCE = -400
export(int) var JUMP_RELEASE_FORCE = -60
export(int) var MAX_SPEED = 150
export(int) var ACCELERATION = 10
export(int) var FRICTION = 30
export(int) var ADDITIONAL_FALL_GRAVITY = 40
export(int) var GRAVITY = 25

func _physics_process(_delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	
	if input.x == 0:
		apply_friction()
		if $AnimatedSprite.animation != "attack1" and $AnimatedSprite.animation != "attack2":
			$AnimatedSprite.play("idle")
	else:
		apply_acceleration(input.x)
		if $AnimatedSprite.animation != "attack2":
			$AnimatedSprite.play("run")
		if input.x > 0:
			$AnimatedSprite.flip_h = false
			$wizard_hitbox.position = Vector2(-4,3)
			$Area2D/hitbox.position = Vector2(23.5,-10)
		elif input.x < 0:
			$AnimatedSprite.flip_h = true
			$wizard_hitbox.position = Vector2(4,3)
			$Area2D/hitbox.position = Vector2(-23.5,-10)
	
	if is_on_floor():
		fast_fell = false
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		$AnimatedSprite.play("jump")
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 10 and not fast_fell:
			velocity.y += ADDITIONAL_FALL_GRAVITY
		fast_fell = true
	
	if is_on_floor() and Input.is_action_just_pressed("ui_attack_1") and input.x == 0:
		$AnimatedSprite.play("attack1")
		if hit_possible:
			print("hit")
	if is_on_floor() and Input.is_action_just_pressed("ui_attack_2"):
		$AnimatedSprite.play("attack2")
		
		
	var was_in_air = not is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		$AnimatedSprite.play("idle")
		$AnimatedSprite.frame = 1

func apply_gravity():
		velocity.y += GRAVITY
		velocity.y = min(velocity.y, 400)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION )
	
func apply_acceleration(ammount):
	velocity.x = move_toward(velocity.x, MAX_SPEED*ammount, ACCELERATION)

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("idle")

func _on_Area2D_body_entered(body):
	if body is Boss:
		hit_possible = true

func _on_Area2D_body_exited(body):
	if body is Boss:
		hit_possible = false
