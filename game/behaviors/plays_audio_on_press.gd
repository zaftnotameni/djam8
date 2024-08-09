@tool
class_name PlaysAudioOnPress extends Node

@export var button : BaseButton

func on_pressed():
	Audio.play_named_ui(NamedAudio.UI.UI_ButtonPress)

func _enter_tree() -> void:
	if not button: button = get_parent()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	button.pressed.connect(on_pressed)
	#button.focus_entered.connect(Audio.play_named_ui.bind(NamedAudio.UI.UI_ButtonFocus))
	#button.mouse_entered.connect(Audio.play_named_ui.bind(NamedAudio.UI.UI_ButtonFocus))
