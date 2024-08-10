@tool
class_name QuitsToTitle extends Node

@export var scene : PackedScene
@export var button : BaseButton
@export var menu : Control

func wipe_all(children:Array=[]):
	for child in children: child.queue_free()

func on_pressed():
	var children_to_wipe := []
	children_to_wipe.append_array(Layers.game.get_children())
	children_to_wipe.append_array(Layers.hud.get_children())
	children_to_wipe.append_array(Layers.menu.get_children())
	var title_screen := scene.instantiate()
	Layers.menu.add_child(title_screen)

	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(menu, ^'position:y', 2000, 0.3).from(0)
	tween.parallel().tween_property(title_screen, ^'position:y', 0, 0.3).from(-2000)
	tween.tween_callback(wipe_all.bind(children_to_wipe))

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
	if not button: button = get_parent()
	if not menu: menu = owner
	if not button.text or button.text.is_empty(): button.text = 'Quit To Title'

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if not scene: scene = load('res://game/menu/title/title_screen.tscn')
	if not scene: push_error('missing scene on %s' % get_path())
	if not button: push_error('missing button on %s' % get_path())
	button.pressed.connect(on_pressed)
