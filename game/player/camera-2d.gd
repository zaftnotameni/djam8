extends Camera2D

var logic : OrbitalDecayLogic

func _ready() -> void:
	if not logic : logic = OrbitalDecayLogic.first()

func _process(delta: float) -> void:
	if not logic : logic = OrbitalDecayLogic.first()
	if not logic: return
	
	if logic.percentage > 0.4:
		offset = lerp(offset, Vector2.ZERO, delta * 1.0)
		return
	var random_x = randf_range(0, 4)
	var random_y = randf_range(0, 4)
	offset = Vector2(random_x, random_y) * clamp(1.0 - logic.percentage * 2.0, 0.0, 1.0)
