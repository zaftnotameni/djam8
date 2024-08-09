@tool
class_name BeepsOnPress extends Node

@export var button : BaseButton

func on_pressed():
	Audio.play_named_ui(NamedAudio.UI.UI_ButtonPress)

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
	if not button: button = get_parent()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	button.pressed.connect(on_pressed)
