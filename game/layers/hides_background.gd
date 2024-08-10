class_name HidesBackground extends Node

func _enter_tree() -> void:
	Layers.layer_background().hide()
