extends AudioStreamPlayer

var logic : OrbitalDecayLogic

func _ready() -> void:
	unmute(0)
	if not logic : logic = OrbitalDecayLogic.first()


func _on_timer_timeout() -> void:
	if not logic : logic = OrbitalDecayLogic.first()
	if not logic: return
	
	if logic.percentage > 0.5:
		unmute(0)
		return
	if logic.percentage > 0.4:
		unmute(1)
		return
	if logic.percentage > 0.35:
		unmute(2)
		return
	if logic.percentage > 0.25:
		unmute(3)
		return
	unmute(4)


func unmute(index: int) -> void:
	for i in stream.stream_count:
		if i == index: continue
		stream.set_sync_stream_volume(i, -60.0)
	stream.set_sync_stream_volume(index, 0.0)
