class_name ControlsOnboardDisplay extends Node

@onready var onboard_display : RichTextLabel = %OnboardDisplay
@onready var logic : OrbitalDecayLogic = OrbitalDecayLogic.first()
@onready var computer_r : Node = %Computer
@onready var computer_v : Node = %Computer2
@onready var computer_d : Node = %Computer3

func _process(_delta: float) -> void:
	if not logic: logic = OrbitalDecayLogic.first()
	if not logic: return
	computer_r.get_node('Label').text = '%.0f\nkm' % logic.orbit_height
	computer_v.get_node('Label').text = '->%.0f\nkm/s' % logic.orbital_velocity
	computer_d.get_node('Label').text = '%s%.0f\nkm/s' % ['+' if logic.saldo >= 0 else '-', abs(logic.saldo)]
	onboard_display.text =\
"""
	Orbital Velocity: %.1f km/s
	Orbital Radius: %.1f km
	Orbital Delta: %.1f km/s

""" % [logic.orbital_velocity, logic.orbit_height, logic.saldo]
