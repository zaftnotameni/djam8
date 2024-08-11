class_name TriggersDefeat extends Node

@export var scene : PackedScene
@export var logic : OrbitalDecayLogic

func wipe_all(children:Array=[]):
	for child in children:
		print_verbose('deleting: ', child.get_path())
		child.queue_free()

func on_defeat():
	Audio.play_named_sfx(NamedAudio.SFX.SFX_ExplosionCrunch003)
	Audio.play_named_sfx(NamedAudio.SFX.SFX_ExplosionCrunch004)
	var children_to_wipe := []
	children_to_wipe.append_array(Layers.game.get_children())
	children_to_wipe.append_array(Layers.hud.get_children())
	children_to_wipe.append_array(Layers.menu.get_children())
	var defeat_screen := scene.instantiate()

	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)

	var ship := get_tree().get_first_node_in_group('ship_tiles') as TileMapLayer
	if ship:
		for cell_id in ship.get_used_cells():
			tween.parallel().tween_callback(ship.erase_cell.bind(cell_id)).set_delay(randf() * 0.3)

	tween.tween_callback(Layers.menu.add_child.bind(defeat_screen))
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
