extends AudioStreamPlayer

var logic : OrbitalDecayLogic

func _ready() -> void:
	if not logic : logic = OrbitalDecayLogic.first()


func _process(_delta: float) -> void:
	if not logic : logic = OrbitalDecayLogic.first()
	if not logic: return

	print(logic.percentage)
