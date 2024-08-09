@tool
class_name Main extends Node2D

func _ready() -> void:
	if Engine.is_editor_hint(): return
