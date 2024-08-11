@tool
class_name PlaysTitleBGM extends Node

@export var plays_on_ready : bool = false
@export var stops_on_exit : bool = false

var _named_audio : String

func set_named_audio(new_value:NamedAudio.All):
	_named_audio = NamedAudio.All.find_key(new_value)

func get_named_audio() -> NamedAudio.All:
	if NamedAudio.All.has(_named_audio):
		return NamedAudio.All[_named_audio]
	else:
		push_error('invalid audio named %s at %s' % [_named_audio, get_path()])
		return NamedAudio.All.Master_VolumeTick

func play():
	Audio.play_named_bgm(NamedAudio.BGM.BGM_PixelSpace)

func stop():
	Audio.stop_named_bgm(NamedAudio.BGM.BGM_PixelSpace)

func _enter_tree() -> void:
	ToolUtil.set_process_always_safe_for_tool(self)

func _exit_tree() -> void:
	if stops_on_exit: stop()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if plays_on_ready: play()
