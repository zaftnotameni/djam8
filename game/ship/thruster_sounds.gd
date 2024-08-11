class_name ThrusterSounds extends Node

@onready var player : AudioStreamPlayer2D = %AudioStreamPlayer2D

func stop_sound():
	player.stop()

func play_sound():
	if not player.playing:
		player.play()

func _process(_delta: float) -> void:
	if owner.has_meta('has_problems') and owner.get_meta('has_problems'): stop_sound()
	else: play_sound()
