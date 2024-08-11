class_name ComputerSounds extends Node

@onready var player : AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var label : Control = owner.get_node('Label')
@onready var tutorial : Sprite2D = %TutorialSprite

func _ready() -> void:
	if owner.has_meta('has_problems') and owner.get_meta('has_problems'):
		tutorial.modulate.a = 1
		tutorial.show()
	else:
		tutorial.modulate.a = 0

func stop_sound():
	player.stop()

func play_sound():
	if not player.playing:
		player.play()

func _process(_delta: float) -> void:
	if owner.has_meta('has_problems') and owner.get_meta('has_problems'):
		play_sound()
		label.hide()
	else:
		stop_sound()
		label.show()
		tutorial.hide()
