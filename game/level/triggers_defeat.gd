class_name TriggersDefeat extends Node

@export var scene : PackedScene
@export var logic : OrbitalDecayLogic

func wipe_all(children:Array=[]):
	for child in children:
		print_verbose('deleting: ', child.get_path())
		child.queue_free()

func on_defeat():
	var children_to_wipe := []
	children_to_wipe.append_array(Layers.game.get_children())
	children_to_wipe.append_array(Layers.hud.get_children())
	children_to_wipe.append_array(Layers.menu.get_children())
	var defeat_screen := scene.instantiate()
	Layers.menu.add_child(defeat_screen)

	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	tween.tween_property(defeat_screen, ^'position:y', 0, 0.3).from(-2000)
	tween.tween_callback(wipe_all.bind(children_to_wipe))

func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if not logic: logic = OrbitalDecayLogic.first()
	if not logic: return
	if logic.orbit_height <= logic.min_orbital_height:
		set_process(false)
		logic.set_process(false)
		on_defeat()

func _enter_tree() -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else ProcessMode.PROCESS_MODE_ALWAYS

func _ready() -> void:
	if not scene: scene = load('res://game/menu/defeat/defeat_screen.tscn')
	if not logic: logic = OrbitalDecayLogic.first()
