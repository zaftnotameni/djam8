extends Label

func _ready() -> void:
	text = '%.1f' % [Config.player_data.decay_level]


