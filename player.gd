extends CharacterBody2D

var move_speed = 130
var acceleration = 900
var friction = 900

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
		
	var direction_vertical = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if abs(direction_vertical) > 0:
		velocity.y = move_toward(velocity.y, direction_vertical * move_speed, delta * acceleration)
	else:
		velocity.y = move_toward(velocity.y, 0.0, delta * friction)
