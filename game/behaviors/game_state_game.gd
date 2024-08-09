class_name GameStateGame extends Node

func _exit_tree() -> void:
	State.pop_game()

func _enter_tree() -> void:
	State.push_game()
