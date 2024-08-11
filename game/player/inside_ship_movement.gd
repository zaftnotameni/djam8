### Controls the player movement inside the ship (only walking)
class_name PlayerInsideShipMovement extends Node

@export var player : CharacterBody2D

func _enter_tree() -> void:
	if not player: player = owner

func _physics_process(delta: float) -> void:
	var input := PlayerInput.input_wasd_normalized()

	if player.is_on_floor():
		player.velocity.x = input.x * Config.player_inside_ship_initial_movement_speed

	if not player.is_on_floor():
		if abs(input.x) > 0.2:
			player.velocity.x = input.x * Config.player_inside_ship_initial_movement_speed * 0.2
		player.velocity.y += Config.player_inside_ship_gravity_acceleration * delta

	player.move_and_slide()

