### flips the target on the x axis if the player is facing left
class_name FlipsOnFacing extends Node

@export var facing : PlayerFacing
@export var target : Node2D 

func on_facing_changed(new_facing):
	match new_facing:
		PlayerFacing.Facing.RIGHT: target.scale.x = 1
		PlayerFacing.Facing.LEFT: target.scale.x = -1

func _enter_tree() -> void:
	if not target: target = get_parent()

func _ready() -> void:
	if not facing: facing = Resolve.at(owner, PlayerFacing)
	facing.sig_facing_changed.connect(on_facing_changed)
	on_facing_changed(facing.facing)
