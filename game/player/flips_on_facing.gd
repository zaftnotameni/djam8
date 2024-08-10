class_name FlipsOnFacing extends Node

@onready var facing : PlayerFacing = Resolve.at(owner, PlayerFacing)

@export var target : Node2D 

func on_facing_changed(new_facing):
	match new_facing:
		PlayerFacing.Facing.RIGHT: target.scale.x = 1
		PlayerFacing.Facing.LEFT: target.scale.x = -1

func _enter_tree() -> void:
	if not target: target = get_parent()

func _ready() -> void:
	facing.sig_facing_changed.connect(on_facing_changed)
