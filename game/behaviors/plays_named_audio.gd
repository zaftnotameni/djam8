@tool
class_name PlaysNamedAudio extends Node

@export var named_audio : NamedAudio.All
@export var plays_on_ready : bool = false
@export var stops_on_exit : bool = false

func play():
	Audio.play_named_all(named_audio)

func stop():
	Audio.stop_named_all(named_audio)

func _enter_tree() -> void:
	ToolUtil.set_process_always_safe_for_tool(self)

func _exit_tree() -> void:
	if stops_on_exit: stop()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if plays_on_ready: play()
