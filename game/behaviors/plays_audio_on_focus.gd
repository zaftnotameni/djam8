@tool
class_name PlaysAudioOnFocus extends Node

@export var button : BaseButton

func on_focus_enter():
	Audio.play_named_ui(NamedAudio.UI.UI_ButtonFocus)

func on_mouse_enter():
	Audio.play_named_ui(NamedAudio.UI.UI_ButtonFocus)

func _enter_tree() -> void:
	if not button: button = get_parent()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	button.focus_entered.connect(on_focus_enter)
	button.mouse_entered.connect(on_mouse_enter)
