class_name GameStateLoading extends Node

func _exit_tree() -> void:
	State.pop_loading()

func _enter_tree() -> void:
	State.push_loading()
