class_name InteriorExteriorTracker extends Node

signal sig_where_changed(new_where:InteriorExterior)

enum InteriorExterior { INTERIOR, EXTERIOR }

@export var area : Area2D

var where : InteriorExterior = InteriorExterior.INTERIOR

func update_where(new_where:InteriorExterior):
	if new_where == where: return
	where = new_where
	sig_where_changed.emit(where)

func on_area_exited(other:Area2D):
	if other.has_meta('ship_interior'):
		update_where(InteriorExterior.EXTERIOR)

func on_area_entered(other:Area2D):
	if other.has_meta('ship_interior'):
		update_where(InteriorExterior.INTERIOR)

func _enter_tree() -> void:
	if not area: area = get_parent()
	area.area_exited.connect(on_area_exited)
	area.area_entered.connect(on_area_entered)
