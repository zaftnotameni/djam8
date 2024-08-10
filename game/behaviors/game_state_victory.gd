# sets the game state to VICTORY when a scene that contains this behavior enters
class_name GameStateVictory extends Node

func _enter_tree() -> void:
	State.mark_as_victory()
