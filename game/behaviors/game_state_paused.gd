class_name GameStatePaused extends Node

func _exit_tree() -> void:
  State.pop_paused()

func _enter_tree() -> void:
  State.push_paused()
