### Keeps track of which direction the player is facing depending on input and velocity
class_name PlayerFacing extends Node

signal sig_facing_changed(new_facing:Facing)

enum Facing { RIGHT, LEFT }

@export var player : CharacterBody2D

var input_x : float
var velocity_x : float
var facing : Facing = Facing.RIGHT

func _physics_process(_delta: float) -> void:
	input_x = PlayerInput.input_wasd_normalized().x
	velocity_x = player.velocity.x
	compute_facing()

### Prefers facing the direction of input, if there's no input then face the direction of the velocity
func compute_facing() -> void:
	if is_player_pressing_left_or_right():
		update_facing(Facing.RIGHT if input_x > 0 else Facing.LEFT)
	elif not is_zero_approx(velocity_x):
		update_facing(Facing.RIGHT if velocity_x > 0 else Facing.LEFT)

func is_player_pressing_left_or_right() -> bool:
	return not is_zero_approx(input_x)

func update_facing(new_facing:Facing):
	if new_facing == facing: return
	facing = new_facing
	sig_facing_changed.emit(facing)

func _enter_tree() -> void:
	if not player: player = owner

