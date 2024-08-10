class_name AtMenu extends Node

@export var scene : PackedScene

func _enter_tree() -> void:
	if not scene: push_error('must provide a scene %s' % get_path())
	Layers.layer_menu().add_child.call_deferred(scene.instantiate())
