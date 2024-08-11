class_name BlackHoleApproaches extends Node

@onready var blackhole : Control = %Planet
var logic : OrbitalDecayLogic

func _ready() -> void:
	if not logic : logic = OrbitalDecayLogic.first()

func _process(_delta: float) -> void:
	if not logic : logic = OrbitalDecayLogic.first()
	if not logic: return
	if not blackhole: return

	blackhole.position.y = 0 + (500 * logic.percentage)
	
