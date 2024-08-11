extends Button

const LEVEL01 := preload('res://game/level/level_001.tscn')

@onready var current_decay_level_label : Label = %CurrentDecayLevel
@onready var next_decay_level_label : Label = %NextDecayLevel

func _ready() -> void:
	current_decay_level_label.text = 'Current Decay Level: %.1f' % [Config.player_data.decay_level]
	next_decay_level_label.text = 'Next Decay Level: %.1f\nEquipment Degrades Slower!' % [Config.player_data.decay_level + 0.5]
	pressed.connect(on_pressed)

func on_pressed():
	Config.player_data.decay_level += 0.5
	Config.player_data.save()
	var game : Node2D = LEVEL01.instantiate()
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.parallel().tween_property(owner, 'modulate:a', 0.0, 0.2).from(1.0)
	tween.parallel().tween_property(owner, 'position:y', 2000, 0.2).from(0.0)
	tween.parallel().tween_callback(Layers.game.add_child.bind(game)).set_delay(0.15)
	tween.tween_callback(owner.queue_free).set_delay(0.05)

