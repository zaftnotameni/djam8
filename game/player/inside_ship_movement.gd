### Controls the player movement inside the ship (only walking)
class_name PlayerInsideShipMovement extends Node

@export var player : CharacterBody2D

func _enter_tree() -> void:
	if not player: player = owner

func _physics_process(delta: float) -> void:
	var input := PlayerInput.input_wasd_normalized()
	var was_not_on_floor := not player.is_on_floor()
	var was_on_floor := player.is_on_floor()

	if player.is_on_floor():
		player.velocity.x = input.x * Config.player_inside_ship_initial_movement_speed

	if player.is_on_floor() and was_on_floor and abs(player.velocity.x) > 0.2:
		Audio.play_named_sfx(NamedAudio.SFX.SFX_StepInsideShip)
	if player.is_on_floor() and was_on_floor and abs(player.velocity.x) < 0.2:
		Audio.stop_named_sfx(NamedAudio.SFX.SFX_StepInsideShip)

	if player.is_on_wall():
		Audio.stop_named_sfx(NamedAudio.SFX.SFX_StepInsideShip)

	if not player.is_on_floor():
		if abs(input.x) > 0.2:
			player.velocity.x = input.x * Config.player_inside_ship_initial_movement_speed * 0.2
		player.velocity.y += Config.player_inside_ship_gravity_acceleration * delta

	player.move_and_slide()

	if player.is_on_floor() and was_not_on_floor:
		Audio.play_named_sfx(NamedAudio.SFX.SFX_LandingOnShip)
