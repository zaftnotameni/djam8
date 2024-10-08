### Controls the player movement outside the ship (jetpack based)
class_name PlayerOutsideShipMovement extends Node

@export var player : CharacterBody2D

func _enter_tree() -> void:
	if not player: player = owner

func stop_jetpack_sound():
	Audio.stop_named_sfx(NamedAudio.SFX.SFX_Jetpack2)

func play_jetpack_sound():
	Audio.play_named_sfx(NamedAudio.SFX.SFX_Jetpack2)

func on_disable():
	stop_jetpack_sound()

func _physics_process(delta: float) -> void:
	var input := PlayerInput.input_wasd_normalized()

	if input.is_zero_approx():
		stop_jetpack_sound()
	else:
		play_jetpack_sound()

	# using acceleration with no damping here, could experiment adding damping but this feels right to me now
	player.velocity.x += input.x * Config.player_outside_ship_acceleration * delta
	player.velocity.y += input.y * Config.player_outside_ship_acceleration * delta

	# limit max speed
	if player.velocity.length() > Config.player_outside_ship_max_speed:
		player.velocity = player.velocity.normalized() * Config.player_outside_ship_max_speed

	player.move_and_slide()
