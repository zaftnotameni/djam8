class_name AllowsPausing extends Node

@export var scene : PackedScene = preload('res://game/menu/pause/pause_screen.tscn')

func _unhandled_input(event: InputEvent) -> void:
	if State.game_state != AutoloadState.GameState.GAME: return
	if event.is_action_pressed('pause'):
		get_viewport().set_input_as_handled()
		show_pause_menu()

func show_pause_menu():
	var pause_menu : Control = scene.instantiate()
	pause_menu.set_process_unhandled_input(false)
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	Layers.menu.add_child(pause_menu)
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(pause_menu, ^'position:x', 0, 0.3).from(-2000)
	tween.tween_callback(pause_menu.set_process_unhandled_input.bind(true))

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
