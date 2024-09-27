extends CharacterBody2D

@export var speed: float = 250

@export var view_radius: float = 200
@onready var view_raycast = $view/RayCast

@onready var player = $"../Player"

var player_seem: bool = false
var chasing: bool = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player_found():
		chase()
	else:
		velocity.x = move_toward(velocity.x, 0, 25)

	move_and_slide()


func chase():
	var direction: float
	if position.x < player.position.x:
		direction = 1
	elif position.x > player.position.x:
		direction = -1
	else:
		direction = 0
	
	velocity.x = move_toward(velocity.x, 250 * direction, 25)

func player_found() -> bool:
	if position.distance_to(player.position) <= view_radius:


		view_raycast.set_target_position(player.global_position - global_position + Vector2(24, -24))
		view_raycast.force_raycast_update()

		if !view_raycast.is_colliding():
			return true
		return false
	else:
		return false
