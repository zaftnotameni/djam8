### toggles the parent particles as emitting if the player is going down
class_name EmittingGoingDown extends Node

@export var particles : CPUParticles2D

func _enter_tree() -> void:
	if not particles: particles = get_parent()

func _physics_process(_delta: float) -> void:
	particles.emitting = PlayerInput.input_wasd_normalized().y > 0
