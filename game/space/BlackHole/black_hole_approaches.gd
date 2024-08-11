class_name BlackHoleApproaches extends Node

var logic : OrbitalDecayLogic

func _ready() -> void:
	if not logic : logic = OrbitalDecayLogic.first()

func _process(_delta: float) -> void:
	if not logic : logic = OrbitalDecayLogic.first()
	if not logic: return

	owner.position.x = 100 + (500 * logic.percentage)
	
