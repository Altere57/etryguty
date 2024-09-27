extends CharacterBody2D


@export var speed: float
@export var jump_force: float

@export var acceleration: float
@export var friction: float

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * (2.5 if velocity.y > 0 else 1.5) * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration)
		
		$"TopSprite".play("run")
		$"BottomSprite".play("run")
		if direction > 0:
			$"TopSprite".flip_h = false
			$"BottomSprite".flip_h = false
		elif direction < 0:
			$"TopSprite".flip_h = true
			$"BottomSprite".flip_h = true
	else:
		$"TopSprite".stop()
		$"BottomSprite".stop()
		velocity.x = move_toward(velocity.x, 0, friction)

	move_and_slide()
