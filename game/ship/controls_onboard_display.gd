class_name ControlsOnboardDisplay extends Node

@onready var onboard_display : RichTextLabel = %OnboardDisplay
@onready var logic : OrbitalDecayLogic = OrbitalDecayLogic.first()

func _process(_delta: float) -> void:
	if not logic: logic = OrbitalDecayLogic.first()
	if not logic: return
	onboard_display.text =\
"""
    Orbital Velocity: %.1f km/s
    Orbital Radius: %.1f km
    Orbital Delta: %.1f km/s

""" % [logic.orbital_velocity, logic.orbit_height, logic.saldo]
