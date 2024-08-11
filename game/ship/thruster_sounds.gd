class_name ThrusterSounds extends Node

@onready var player : AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var party_good : CPUParticles2D = %PartyThrusterLeft
@onready var party_bad : CPUParticles2D = %PartyThrusterLeftDamaged

func stop_sound():
	player.stop()

func play_sound():
	if not player.playing:
		player.play()

func _process(_delta: float) -> void:
	if owner.has_meta('has_problems') and owner.get_meta('has_problems'):
		stop_sound()
		party_bad.emitting = true
		party_good.emitting = false
	else:
		play_sound()
		party_good.emitting = true
		party_bad.emitting = false
