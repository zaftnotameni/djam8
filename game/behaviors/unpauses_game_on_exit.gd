@tool
class_name UnpausesGameOnExit extends Node

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS

func _exit_tree() -> void:
	if Engine.is_editor_hint(): return
	get_tree().paused = false
