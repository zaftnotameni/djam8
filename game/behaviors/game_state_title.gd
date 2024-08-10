# sets the game state to TITLE when a scene that contains this behavior enters
class_name GameStateTitle extends Node

func _enter_tree() -> void:
	State.mark_as_title()
