extends CharacterBody2D


const SPEED = 180.0
const JUMP_VELOCITY = -250.0
const MAX_FALL_SPEED = 400
@onready var anime=$AnimatedSprite2D
var direction = 1
var jump_count = 0
var gravity_strength = 980



func _physics_process(delta: float) -> void:
	
	handle_jump()
	handle_movement()
	move_and_slide()
	apply_gravity(delta)
	update_animation()


func handle_jump() -> void:
	
	if is_on_floor():
		jump_count=0
	if jump_count == 0 and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	elif jump_count == 1 and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.3


func apply_gravity(delta: float) -> void:
	if not is_on_floor() and velocity.y < MAX_FALL_SPEED:
		velocity.y += gravity_strength * delta


func handle_movement() -> void:
	direction = Input.get_axis("ui_left", "ui_right") 
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func update_animation() -> void:
	if direction==-1:
	
		anime.flip_h = true
		
	elif direction == 1:
		anime.flip_h = false
		
	
	if not is_on_floor():
		anime.play("jump")
	
	elif abs(velocity.x) > 5:
		anime.play("run")
	
	else:
		anime.play("idle")
