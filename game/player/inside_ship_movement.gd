class_name PlayerInsideShipMovement extends Node

@onready var player : CharacterBody2D = owner

func _physics_process(delta: float) -> void:
	var input := PlayerInput.input_wasd_normalized()
	player.velocity.x = input.x * Config.player_inside_ship_initial_movement_speed
	player.velocity.y += Config.player_inside_ship_gravity_acceleration * delta
	player.move_and_slide()
