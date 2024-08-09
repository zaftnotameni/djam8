@tool
class_name AutoFocuses extends Node

@export var button : BaseButton

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS
	if not button: button = get_parent()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if not button: push_error('missing button on %s' % get_path())
	button.grab_focus.call_deferred()
