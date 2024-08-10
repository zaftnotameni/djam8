# sets the game state to DEFEAT when a scene that contains this behavior enters
class_name GameStateDefeat extends Node

func _enter_tree() -> void:
	State.mark_as_defeat()
