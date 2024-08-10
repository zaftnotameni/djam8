@tool
### closes the target menu
class_name ClosesMenu extends Node

@export var menu : Control
@export var button : BaseButton

func on_pressed():
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(menu, ^'position:x', -2000, 0.3).from(0)
	tween.tween_callback(menu.queue_free)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action('ui_cancel'): on_pressed()

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
	if not menu: menu = owner
	if not button: button = get_parent()
	if not button.text or button.text.is_empty(): button.text = 'Back'

func _ready() -> void:
	if Engine.is_editor_hint(): return
	button.pressed.connect(on_pressed)
