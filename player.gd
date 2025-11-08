extends CharacterBody2D

@export var move_speed = 130
@export var acceleration = 900
@export var friction = 900
@export var jump_strength = 100
@export var gravity = 200

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	move(delta)
	move_and_slide()
	
func move(delta):
	var direction_horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction_horizontal > 0:
		sprite_2d.flip_h = false
	elif direction_horizontal < 0:
		sprite_2d.flip_h = true
	
	if abs(direction_horizontal) > 0:
		velocity.x = move_toward(velocity.x, direction_horizontal * move_speed, delta * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0.0, delta * friction)
		
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = -jump_strength
		
	if not is_on_floor():
		velocity.y += gravity * delta
