### Keeps track of the target area if it enters/leaves an area with meta[ship_interior=true]
class_name InteriorExteriorTracker extends Node

const INTERIOR_EXTERIOR_TRACKER_GROUP_NAME := 'interior_exterior_tracker'

signal sig_where_changed(new_where:InteriorExterior)

enum InteriorExterior { INTERIOR, EXTERIOR }

@export var area : Area2D

var where : InteriorExterior = InteriorExterior.INTERIOR

func is_inside() -> bool: return where == InteriorExterior.INTERIOR
func is_outside() -> bool: return where == InteriorExterior.EXTERIOR

func update_where(new_where:InteriorExterior):
	if new_where == where: return
	where = new_where
	sig_where_changed.emit(where)

func on_area_exited(other:Area2D):
	# for the sake of simplicity for the jam, using a meta tag instead of layers
	if other.has_meta('ship_interior'):
		print_verbose('player exited ship')
		update_where(InteriorExterior.EXTERIOR)
		Audio.play_named_sfx(NamedAudio.SFX.SFX_GoOutside)

func on_area_entered(other:Area2D):
	# for the sake of simplicity for the jam, using a meta tag instead of layers
	if other.has_meta('ship_interior'):
		print_verbose('player entered ship')
		update_where(InteriorExterior.INTERIOR)
		Audio.play_named_sfx(NamedAudio.SFX.SFX_GoInside)

func _enter_tree() -> void:
	add_to_group(INTERIOR_EXTERIOR_TRACKER_GROUP_NAME)
	if not area: area = get_parent()
	area.area_entered.connect(on_area_entered)
	area.area_exited.connect(on_area_exited)

static func first() -> InteriorExteriorTracker:
	var tree := Engine.get_main_loop() as SceneTree
	return tree.get_first_node_in_group(INTERIOR_EXTERIOR_TRACKER_GROUP_NAME) as InteriorExteriorTracker
