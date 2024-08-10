class_name PlayerOutsideShipMovement extends Node

@onready var player : CharacterBody2D = owner

func _physics_process(delta: float) -> void:
	var input := PlayerInput.input_wasd_normalized()
	player.velocity.x += input.x * Config.player_outside_ship_acceleration * delta
	player.velocity.y += input.y * Config.player_outside_ship_acceleration * delta
	if player.velocity.length() > Config.player_outside_ship_max_speed:
		player.velocity = player.velocity.normalized() * Config.player_outside_ship_max_speed
	player.move_and_slide()
