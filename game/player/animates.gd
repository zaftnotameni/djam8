class_name PlayerAnimates extends Node

@export var animation_player : AnimationPlayer
@export var player : CharacterBody2D
@export var tracker : InteriorExteriorTracker

func _enter_tree() -> void:
	if not player: player = owner

func _ready() -> void:
	if not animation_player: animation_player = %AnimationPlayer
	if not tracker: tracker = InteriorExteriorTracker.first()

func _physics_process(_delta: float) -> void:
	if player.is_on_floor() and not player.velocity.is_zero_approx() and tracker.is_inside():
		animation_player.play('walk')
	elif not player.is_on_floor():
		animation_player.play('jump')
	elif player.velocity.is_zero_approx():
		animation_player.play('idle')
