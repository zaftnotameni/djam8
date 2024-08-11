class_name TitleAnimation extends Node

@onready var black_hole : Control = %Planet
@onready var btn_start : BaseButton = %Start
@onready var btn_options : Control = %Options
@onready var btn_about : Control = %About
@onready var buttons : Control = %Buttons
@onready var logo : Node2D = %Logo

const LEVEL01 := preload('res://game/level/level_001.tscn')

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS

func _ready() -> void:
	btn_start.hide()
	btn_options.hide()
	btn_about.hide()
	logo.hide()
	buttons.hide()
	btn_start.pressed.connect(on_start)
	if owner.has_meta('delay_animation'): get_tree().create_timer(0.5).timeout.connect(animate, CONNECT_ONE_SHOT)
	else: animate()

func on_start():
	var game : Node2D = LEVEL01.instantiate()
	btn_start.show()
	btn_options.show()
	btn_about.show()
	logo.show()
	buttons.show()
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(btn_start, 'position:x', 2000, 0.4).from(0)
	tween.parallel().tween_property(btn_options, 'position:x', 2000, 0.8).from(0)
	tween.parallel().tween_property(btn_about, 'position:x', 2000, 1.2).from(0)
	tween.parallel().tween_property(logo, 'position:y', -2000, 1.6).from(-100)
	tween.tween_property(black_hole, 'position:y', 2000, 0.8).from(-180)
	tween.parallel().tween_property(owner, 'modulate:a', 0.0, 0.8).from(1.0)
	tween.parallel().tween_callback(Layers.game.add_child.bind(game)).set_delay(0.6)
	tween.tween_callback(owner.queue_free).set_delay(0.1)

func animate():
	btn_start.hide()
	btn_options.hide()
	btn_about.hide()
	logo.hide()
	buttons.hide()
	buttons.modulate.a = 0
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(logo, 'position:y', -100, 1.0).from(-2000)
	tween.parallel().tween_callback(logo.show).set_delay(0.1)
	tween.tween_property(btn_start, 'position:x', 0.0, 0.5).from(2000)
	tween.parallel().tween_property(btn_options, 'position:x', 0.0, 1.0).from(2000)
	tween.parallel().tween_property(btn_about, 'position:x', 0.0, 1.5).from(2000)
	tween.parallel().tween_callback(btn_start.show).set_delay(0.1)
	tween.parallel().tween_callback(btn_options.show).set_delay(0.1)
	tween.parallel().tween_callback(btn_about.show).set_delay(0.1)
	tween.parallel().tween_callback(buttons.show).set_delay(0.1)
	tween.parallel().tween_property(buttons, 'modulate:a', 1.0, 0.1).from(0.0)
	tween.tween_callback(btn_start.grab_focus)