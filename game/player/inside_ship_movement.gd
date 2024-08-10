### Controls the player movement inside the ship (only walking)
class_name PlayerInsideShipMovement extends Node

@export var player : CharacterBody2D

func _enter_tree() -> void:
	if not player: player = owner

func _physics_process(delta: float) -> void:
	var input := PlayerInput.input_wasd_normalized()
	player.velocity.x = input.x * Config.player_inside_ship_initial_movement_speed
	player.velocity.y += Config.player_inside_ship_gravity_acceleration * delta
	player.move_and_slide()
