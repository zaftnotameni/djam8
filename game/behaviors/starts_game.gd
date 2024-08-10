@tool
class_name StartsGame extends Node

@export var menu : Control
@export var scene : PackedScene
@export var button : BaseButton

func on_pressed():
	var game : Node2D = scene.instantiate()
	Layers.game.add_child(game)
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(game, ^'position:x', 0, 0.3).from(2000)
	tween.parallel().tween_property(menu, ^'position:x', -2000, 0.3).from(0)
	tween.tween_callback(owner.queue_free)

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
	if not button: button = get_parent()
	if not menu: menu = owner
	if not button.text or button.text.is_empty(): button.text = 'Start'

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if not scene: push_error('missing scene on %s' % get_path())
	if not button: push_error('missing button on %s' % get_path())
	button.pressed.connect(on_pressed)
