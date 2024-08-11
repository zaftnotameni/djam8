@tool
class_name PlaysTitleBGM extends Node

@export var plays_on_ready : bool = false
@export var stops_on_exit : bool = false

func play():
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_AboutToWin)
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_DefaultSpace)
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_AboutToLose)
	Audio.play_named_bgm(NamedAudio.BGM.BGM_PixelSpace)

func stop():
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_AboutToWin)
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_DefaultSpace)
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_AboutToLose)
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_PixelSpace)

func _enter_tree() -> void:
	ToolUtil.set_process_always_safe_for_tool(self)

func _exit_tree() -> void:
	if stops_on_exit: stop()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if plays_on_ready: play.call_deferred()
