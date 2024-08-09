@tool
class_name OpensSubMenu extends Node

@export var scene : PackedScene
@export var button : BaseButton

func on_pressed():
	var sub_menu : Control = scene.instantiate()
	owner.add_sibling(sub_menu)
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(sub_menu, ^'position:x', 0, 0.3).from(-2000)
	sub_menu.tree_exiting.connect(Audio.ignore_next.bind(Audio.get_name_ui(NamedAudio.UI.UI_ButtonFocus)))
	sub_menu.tree_exited.connect(button.grab_focus)

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
	if not button: button = get_parent()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if not scene: push_error('missing scene on %s' % get_path())
	if not button: push_error('missing button on %s' % get_path())
	button.pressed.connect(on_pressed)
